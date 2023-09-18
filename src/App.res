%%raw(`import "./App.css";`)
open ChartData

@react.component
let make = () => {
  let (loanAmt, setLoanAmt) = React.useState(_ => 100000.00)
  let (rateOfInterest, setRateOfInterest) = React.useState(_ => 6.00)
  let (loanTenure, setLoanTenure) = React.useState(_ => 2.00)
  let (emi, setEmi) = React.useState(_ => 0.00)

  let data: array<ChartData.chartData> = [
    {name: "Page A", uv: 4000, pv: 2400, amt: 2400, color: "#0088FE"},
    {name: "Page B", uv: 3000, pv: 1398, amt: 2210, color: "#00C49F"},
  ]

  let handleEmiChange = () => {
    let monthlyROI = rateOfInterest /. 12.0 /. 100.0
    let monthlyTenure = loanTenure *. 12.0
    let rateOfInterestPow = Js.Math.pow_float(~base=1.0 +. monthlyROI, ~exp=monthlyTenure)
    let emiAmt = loanAmt *. monthlyROI *. rateOfInterestPow /. (rateOfInterestPow -. 1.0)
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
        <span> {React.string(Belt.Int.toString(Belt.Float.toInt(emi)))} </span>
      </div>
      <div className="display-pie-chart">
        <PieChart data={data} />
      </div>
    </div>
  </div>
}
