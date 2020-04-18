#Indices
I = 1:3; #different types of biodiesel.
J = 1:3; #different types of crops.

#Labels
biodiesel = ["B5","B30","B100"];
crops = ["soybeans","sunflower","cotton"];

#Resources
TotalHektar = 1600; #hektars
TotalWater = 5000; #ML (megaliters)
TotalPetrol = 150000; #Liters
TotalDemand = 280000; #Liters

        #Yield          Water demand Oil content
        #[kg/ha]       [ML]            [l/kg]
crops_data =   [2600     5.0             0.178 #soybeans
                1400     4.2             0.216 #sunflower
                900     1.0             0.433]; #cotton
#proportion of biodiesel, price [euro/L], Tax (Columns)
product_data = [0.05 1.43 0.20 #B5
                0.30 1.29 0.05 #B30
                1.00 1.16 0.00]; #B100

cost_meth = 1.5; #cost per liter of meth
cost_petrol = 1; #cost per liter of petrol

#Calculated cost per liter for every biodiesel
#Cost per liter
#Every biodiesel contains a mixture of biodiesel and petrol
#biodiesel blend: 0.9bio = 1oil +0.2 meth
blendbio = 0.9;
blendoil = 1;
blendmeth = 0.2;
B5cost = 1-product_data[1,1]+(blendmeth/(blendbio/product_data[1,1]))*cost_meth;
B30cost = 1 - product_data[2,1]+(blendmeth/(blendbio/product_data[2,1]))*cost_meth;
B100cost = 1-product_data[3,1]+(blendmeth/(blendbio/product_data[3,1]))*cost_meth;
#Profit per liter
B5profit = product_data[1,2]*(1-product_data[1,3])-B5cost; #profit for different biodiesels
B30profit = product_data[2,2]*(1-product_data[2,3]) - B30cost;
B100profit = product_data[3,2]*(1-product_data[3,3]) - B100cost;
profit = [B5profit,B30profit,B100profit];

#Tänkt rätt med att blanda in % olja?
cropyield = zeros(3,3);
for i = 1:length(I)
        for j=1:length(J)
                cropyield[i,j] = crops_data[j,3]^(-1)*product_data[i,1]/blendbio;
        end
end
