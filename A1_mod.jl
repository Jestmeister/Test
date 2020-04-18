#Makes a mathematical model for the problem
function build_product_model(data_file::String)
    #Include the data
    include(data_file)

    #Creates an empty model
    m=Model()

    #Defines the variables
    @variable(m, x[I] >= 0)

    #Defines the profit-funtion
    @objective(m, Max,
    sum((product_data[i,2]*(1-product_data[i,3])-cost_petrol*(1-product_data[i,1])-2/9*cost_meth*product_data[i,1])*x[i] for i in I))

    #Rätt syntax?

    #Demand constraint
    @constraint(m, Total_Demand,sum(x[i] for i in I) == TotalDemand)

    #Petrol diesel constraint
    @constraint(m, Petrol_Demand, 0 <= sum((1-product_data[i,1])*x[i] for i in I) <= TotalPetrol)

    #Area constraint, problem med två summeringar
    @constraint(m, Area_Demand, 0 <= sum(sum(cropyield[i,j]/crops_data[j,1]*x[i] for j in J) for i in I) <= TotalHektar)

    #Water constraint
    @constraint(m, Water_Demand, 0 <= sum( sum(cropyield[i,j]/crops_data[j,1]*x[i]*crops_data[j,2] for j in J) for i in I) <= TotalWater)

    return m,x,Total_Demand,Petrol_Demand,Area_Demand,Water_Demand
end
