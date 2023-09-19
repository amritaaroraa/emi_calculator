%%raw(`import "./App.css";`)
open ChartData

@react.component
let make = () => {
  let (loanAmt, setLoanAmt) = React.useState(_ => 100000.00)
  let (rateOfInterest, setRateOfInterest) = React.useState(_ => 6.00)
  let (loanTenure, setLoanTenure) = React.useState(_ => 5.00)
  let (interestAmt, setInterestAmt) = React.useState(_ => 0.00)
  let (emi, setEmi) = React.useState(_ => 0.00)

  let data: array<ChartData.chartData> = [
    {name: "Principal Amt", uv: 100000, color: "#0088FE"},
    {name: "Interest Amt", uv: 1000, color: "#00C49F"},
  ]

  let (chartData, setChartData) = React.useState(_ => data)

  let handleEmiChange = () => {
    let monthlyROI = rateOfInterest /. 12.0 /. 100.0
    let monthlyTenure = loanTenure *. 12.0
    let rateOfInterestPow = Js.Math.pow_float(~base=1.0 +. monthlyROI, ~exp=monthlyTenure)
    let emiAmt = loanAmt *. monthlyROI *. rateOfInterestPow /. (rateOfInterestPow -. 1.0)
    let intAmt = emiAmt *. monthlyTenure -. loanAmt
    let pieChartData: array<ChartData.chartData> = [
      {name: "Principal Amt", color: "#0088FE", uv: Belt.Float.toInt(loanAmt)},
      {name: "Interest Amt", color: "#00C49F", uv: Belt.Float.toInt(intAmt)},
    ]

    setChartData(_ => pieChartData)
    setInterestAmt(_ => intAmt)
    setEmi(_ => emiAmt)
  }

  let handleLoanAmtInput = e => {
    let loanAmt = ReactEvent.Form.target(e)["value"]
    setLoanAmt(loanAmt)
  }

  let handleRateOfInterest = e => {
    let rateOfInt = ReactEvent.Form.target(e)["value"]
    setRateOfInterest(rateOfInt)
  }

  let handleLoanTenure = e => {
    let tenure = ReactEvent.Form.target(e)["value"]
    setLoanTenure(tenure)
  }

  React.useEffect3(() => {
    handleEmiChange()
    None
  }, (loanAmt, rateOfInterest, loanTenure))

  <div className="App">
    <span className="title"> {React.string("EMI Calculator")} </span>
    <SliderInput
      title="Loan Amount"
      underlineTitle={"₹ " ++ Belt.Float.toString(loanAmt)}
      onChange={handleLoanAmtInput}
      state={loanAmt}
      min={100000}
      max={100000000}
    />
    <SliderInput
      title="Rate of Interest(p.a)"
      underlineTitle={Belt.Float.toString(rateOfInterest) ++ "%"}
      onChange={handleRateOfInterest}
      state={rateOfInterest}
      min={1}
      max={30}
    />
    <SliderInput
      title="Loan tenure (years)"
      underlineTitle={Belt.Float.toString(loanTenure) ++ "Yr"}
      onChange={handleLoanTenure}
      state={loanTenure}
      min={1}
      max={30}
    />
    <div className="card">
      <div className="container">
        <span className="left-column"> {React.string("Monthly EMI ")} </span>
        <span className="right-column">
          {React.string(Belt.Int.toString(Belt.Float.toInt(emi)))}
        </span>
      </div>
      <div className="container">
        <span className="left-column"> {React.string("Principal Amount ")} </span>
        <span className="right-column">
          {React.string(Belt.Int.toString(Belt.Float.toInt(loanAmt)))}
        </span>
      </div>
      <div className="container">
        <span className="left-column"> {React.string("Interest Amount ")} </span>
        <span className="right-column">
          {React.string(Belt.Int.toString(Belt.Float.toInt(interestAmt)))}
        </span>
      </div>
      <div className="display-pie-chart">
        <PieChart data={chartData} />
      </div>
    </div>
  </div>
}
