//
//  ScheduleViewController.swift
//  SportEventScheduler
//
//  Created by Mirzhan Gumarov on 12/3/17.
//  Copyright © 2017 Mirzhan Gumarov. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ScheduleViewController: ViewController {
    let stackView = UIStackView()
    let calendarView = JTAppleCalendarView()
    let tableView = UITableView()
    
    let monday = DayView(day: "Mon")
    let tuesday = DayView(day: "Tue")
    let wednesday = DayView(day: "Wed")
    let thursday = DayView(day: "Thu")
    let friday = DayView(day: "Fri")
    let saturday = DayView(day: "Sat")
    let sunday = DayView(day: "Sun") 
    
    // MARK: Config
    let formatter = DateFormatter()
    let dateFormatterString = "yyyy MM dd"
    let numOfRowsInCalendar = 6
    let numOfRandomEvent = 100
    let calendarCellIdentifier = "calendarCell"
    let scheduleCellIdentifier = "cell"
    
    var date: Date?
    
    var scheduleGroup : [String: [Schedule]]? {
        didSet {
            calendarView.reloadData()
            tableView.reloadData()
        }
    }
    
    var schedules: [Schedule] {
        get {
            guard let selectedDate = calendarView.selectedDates.first else {
                return []
            }
            
            guard let data = scheduleGroup?[self.formatter.string(from: selectedDate)] else {
                return []
            }
            
            return data.sorted()
        }
    }
    
    var numOfRowIsSix: Bool {
        get {
            return calendarView.visibleDates().outdates.count < 7
        }
    }
    
    var currentMonthSymbol: String {
        get {
            let startDate = (calendarView.visibleDates().monthDates.first?.date)!
            let month = Calendar.current.dateComponents([.month], from: startDate).month!
            let monthString = DateFormatter().monthSymbols[month-1]
            return monthString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Schedule"
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(showTodayWithAnimate))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: scheduleCellIdentifier)
        
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
        calendarView.register(DayViewCell.self, forCellWithReuseIdentifier: calendarCellIdentifier)
    
        setupStackView()
        setupCalendar()
        
        view.addSubview(stackView)
        view.addSubview(calendarView)
        view.addSubview(tableView)
        
        addConstraints()
        showToday(animate: false)
    }
    
    
    private func addConstraints() {
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.height.equalTo(20)
            make.width.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        calendarView.snp.makeConstraints { (make) in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(calendarView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func dismissViewController(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension ScheduleViewController {
    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        stackView.addArrangedSubview(monday)
        stackView.addArrangedSubview(tuesday)
        stackView.addArrangedSubview(wednesday)
        stackView.addArrangedSubview(thursday)
        stackView.addArrangedSubview(friday)
        stackView.addArrangedSubview(saturday)
        stackView.addArrangedSubview(sunday)
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupCalendar() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.isPagingEnabled = true
        calendarView.showsVerticalScrollIndicator = false
        calendarView.backgroundColor = .white
    }
    
    private func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
        
        let year = Calendar.current.component(.year, from: startDate)
        title = "\(year) \(currentMonthSymbol)"
    }
}

extension ScheduleViewController {
    func select(onVisibleDates visibleDates: DateSegmentInfo) {
        guard let firstDateInMonth = visibleDates.monthDates.first?.date else
        { return }
        
        if firstDateInMonth.isThisMonth() {
            calendarView.selectDates([Date()])
        } else {
            calendarView.selectDates([firstDateInMonth])
        }
    }
}

extension ScheduleViewController {
    @objc func showTodayWithAnimate() {
        showToday(animate: true)
    }
    
    func showToday(animate:Bool) {
        calendarView.scrollToDate(Date(), triggerScrollToDateDelegate: true, animateScroll: animate, preferredScrollPosition: nil, extraAddedOffset: 0) { [unowned self] in
            self.getSchedule()
            self.calendarView.visibleDates {[unowned self] (visibleDates: DateSegmentInfo) in
                self.setupViewsOfCalendar(from: visibleDates)
            }
            
            //self.adjustCalendarViewHeight()
            self.calendarView.selectDates([Date()])
        }
    }
}

extension ScheduleViewController {
    func getSchedule() {
        if let startDate = calendarView.visibleDates().monthDates.first?.date  {
            let endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)
            getSchedule(fromDate: startDate, toDate: endDate!)
        }
    }
    
    
    func getSchedule(fromDate: Date, toDate: Date) {
        var schedules: [Schedule] = []
        for _ in 1...numOfRandomEvent {
            schedules.append(Schedule(fromStartDate: fromDate))
        }
        
        scheduleGroup = schedules.group{self.formatter.string(from: $0.startTime)}
    }
}

extension ScheduleViewController {
    func configureCell(view: JTAppleCell?, cellState: CellState) {
        guard let myCustomCell = view as? DayViewCell else { return }
        
        myCustomCell.dayLabel.text = cellState.text
        let cellHidden = cellState.dateBelongsTo != .thisMonth
        
        myCustomCell.isHidden = cellHidden
        myCustomCell.selectedView.backgroundColor = UIColor.black
        
        if Calendar.current.isDateInToday(cellState.date) {
            myCustomCell.selectedView.backgroundColor = UIColor.red
        }
        
        handleCellTextColor(view: myCustomCell, cellState: cellState)
        handleCellSelection(view: myCustomCell, cellState: cellState)
        
        if scheduleGroup?[formatter.string(from: cellState.date)] != nil {
            myCustomCell.eventView.isHidden = false
        }
        else {
            myCustomCell.eventView.isHidden = true
        }
    }
    
    func handleCellSelection(view: DayViewCell, cellState: CellState) {
        view.selectedView.isHidden = !cellState.isSelected
    }
    
    func handleCellTextColor(view: DayViewCell, cellState: CellState) {
        if cellState.isSelected {
            view.dayLabel.textColor = UIColor.white
        }
        else {
            view.dayLabel.textColor = UIColor.black
            if cellState.day == .sunday || cellState.day == .saturday {
                view.dayLabel.textColor = UIColor.gray
            }
        }
        
        if Calendar.current.isDateInToday(cellState.date) {
            if cellState.isSelected {
                view.dayLabel.textColor = UIColor.white
            }
            else {
                view.dayLabel.textColor = UIColor.red
            }
        }
    }
}

extension ScheduleViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = dateFormatterString
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2019 02 01")!
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: numOfRowsInCalendar,
                                                 calendar: Calendar.current,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfGrid,
                                                 firstDayOfWeek: .monday,
                                                 hasStrictBoundaries: true)
        
        return parameters
    }
    
    
}

extension ScheduleViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: calendarCellIdentifier, for: indexPath) as! DayViewCell
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: calendarCellIdentifier, for: indexPath) as! DayViewCell
        configureCell(view: cell, cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
        if visibleDates.monthDates.first?.date == date {
            return
        }
        
        date = visibleDates.monthDates.first?.date
        
        getSchedule()
        select(onVisibleDates: visibleDates)
        
        view.layoutIfNeeded()
        
        //adjustCalendarViewHeight()
        
        UIView.animate(withDuration: 0.5) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
        tableView.reloadData()
        tableView.contentOffset = CGPoint()
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
}

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: scheduleCellIdentifier) as! ScheduleTableViewCell
        
        cell.selectionStyle = .none
        cell.schedule = schedules[indexPath.row]
        
        return cell
    }
}

extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let schedule = schedules[indexPath.row]
            
            print(schedule)
            print("schedule selected")
        }
    }
}
