
using JuMP      #load the package JuMP
using Gurobi       #load the package Gurobi


#Build the model and get variables and constraints back (see intro_mod.jl)
include("A1_mod.jl")
m, x ,Total_Demand,Petrol_Demand,Area_Demand,Water_Demand= build_product_model("A1_data.jl")
print(m) # prints the model instance

set_optimizer(m, Gurobi.Optimizer)

optimize!(m)


function get_slack(constraint::ConstraintRef)::Float64  # If you dont want you dont have to specify types
  con_func = constraint_object(constraint).func
  interval = MOI.Interval(constraint_object(constraint).set)
  row_val = value(con_func)
  return min(interval.upper - row_val, row_val - interval.lower)
end


println("z =  ", objective_value(m))   		# display the optimal solution
println("x =  ", value.(x.data))          # f.(arr) applies f to all elements of arr
#println("Foods in solution: ", foods[[value(x[i]) > 0 for i in I]])
println("reduced cost =  ", dual.(LowerBoundRef.(x.data)))
#protein_demand = nutrition_demands[findfirst(nutrients .== "protein")]
#println("protein dual =  ", dual(protein_demand)) # See JuMP doc for dual vs shadow_price
println("Customer demand dual = ", dual(Total_Demand))
println("Customer demand slack = ", get_slack(Total_Demand))
println("Petrol supply dual = ", dual(Petrol_Demand))
println("Area dual = ", dual(Area_Demand))
println("Water supply dual = ", dual(Water_Demand))


using MathOptInterface
