require 'json'

file = File.read('address.json')

data_hash = JSON.parse(file)

namespace :import do
    task import_task: :environment do

        #Creating users to be imported
        users = []
        i = User.count + 1
        1.times do
            users << User.new(
                id: i,
                email: Faker::Internet.unique.safe_email, 
                password: Faker::Internet.password(min_length: 6, max_length: 15),
                # admin: Faker::Boolean.boolean(true_ratio: 0.2) #If importing new employees, uncomment this boolean
            )
            i += 1
        end
        # User.import! users

        #ADD EMPLOYEE IMPORT

        #Creating quotes to be imported
        quotes = []
        building_type_options = ["residential", "commercial", "corporate", "hybrid"]
        building_type = building_type_options[Faker::Number.between(from: 0, to: 3)]
        tier = ["standard", "premium", "excelium"]
        tier_selected = tier[Faker::Number.between(from: 0, to: 2)]
        total_price = ''
        if building_type == "residential"
            number_of_apartment = Faker::Number.between(from: 30, to: 600)
            number_of_floors = Faker::Number.between(from: 1, to: 60)
            number_of_basements = Faker::Number.between(from: 1, to: 5)
        elsif building_type == "commercial"
            number_of_floors = Faker::Number.between(from: 1, to: 60)
            number_of_basements = Faker::Number.between(from: 1, to: 10)
            number_of_businesses = Faker::Number.between(from: 1, to: 50)
            number_of_parking_spots = Faker::Number.between(from: 50, to: 1000)
            number_of_cages = Faker::Number.between(from: 1, to: 50)
        elsif building_type == "corporate"
            number_of_floors = Faker::Number.between(from: 1, to: 60)
            number_of_basements = Faker::Number.between(from: 1, to: 10)
            number_of_parking_spots = Faker::Number.between(from: 50, to: 1000)
            number_of_corporations = Faker::Number.between(from: 1, to: 50)
            occupants_per_floor = Faker::Number.between(from: 50, to: 500)
        elsif building_type == "hybrid"
            number_of_floors = Faker::Number.between(from: 1, to: 60)
            number_of_basements = Faker::Number.between(from: 1, to: 50)
            number_of_businesses = Faker::Number.between(from: 1, to: 50)
            number_of_parking_spots = Faker::Number.between(from: 50, to: 1000)
            occupants_per_floor = Faker::Number.between(from: 50, to: 500)
            number_of_active_hours = Faker::Number.between(from: 1, to: 24)
            number_of_corporations = Faker::Number.between(from: 1, to: 50)
        end
        if tier_selected == "standard"
            unit_price = "$7,565.00"
        elsif tier_selected == "premium"
            unit_price = "$12,345.00"
        elsif tier_selected == "excelium"
            unit_price = "$15,400.00"
        end
        i = Quote.count + 1
        1.times do
            quotes << Quote.new(
                id: i,
                name: Faker::Name.name,
                email: Faker::Internet.unique.safe_email, 
                phone: Faker::PhoneNumber.phone_number,
                bType: building_type,
                numApart: number_of_apartment,
                numFloor: number_of_floors,
                numBase: number_of_basements,
                numBusi: number_of_businesses,
                numPark: number_of_parking_spots,
                numCage: number_of_cages,
                occpFloor: occupants_per_floor,
                numHour: number_of_active_hours,
                numCorp: number_of_corporations,
                product: tier_selected,
                numElev: Faker::Number.between(from: 0, to: 30),
                unitP: unit_price,
                totalP: "$1,000",
                instalP: "$1,000",
                finalP: "$1,000"
            )
            i += 1
        end
        Quote.import! quotes
        p quotes

        #Createing leads to be imported
        leads = []
        i = Lead.count + 1
        1.times do
            leads << Lead.new(
                id: i,
                full_name_of_the_contact: Faker::Name.name,
                company_name: Faker::Company.name,
                email: Faker::Internet.unique.safe_email, 
                phone: Faker::PhoneNumber.phone_number,
                project_name: Faker::Lorem.sentence(word_count: 3),
                project_description: Faker::Lorem.sentence(word_count: 10),
                department_in_charge_of_the_elevators: Faker::Lorem.sentence(word_count: 2),
                message: Faker::Lorem.sentence(word_count: 20),
                date_of_the_contact: Faker::Date.between(from: 3.years.ago, to: Date.today)
            )
            i += 1
        end
        # Lead.import! leads

        #Creating customer addresses to be imported
        customer_addresses = []
        address_type = ["Residential", "Commercial", "Corporate", "Hybrid"]
        status = ["Active", "Inactive"]
        i = Address.count + 1
        users.each do
            random_address = data_hash['addresses'][Faker::Number.between(from: 0, to: 499)]
            customer_addresses << Address.new(
                id: i,
                type_of_address: address_type[Faker::Number.between(from: 0, to: 3)],
                status: status[Faker::Number.between(from: 0, to: 1)],
                entity: "Customer",
                number_and_street: random_address['address1'],
                suite_or_apartment: random_address['address2'],
                city: random_address['city'],
                postal_code: random_address['postalCode'],
                country: random_address['state'],
                notes: "No current notes for this address."
            )
            i += 1
        end
        # Address.import! customer_addresses

        #Cloning customrer address and changing entity to building
        building_addresses = []
        i = Address.count + 1
        x = 0
        customer_addresses.each do
            building_addresses << Address.new(
                id: i,
                type_of_address: customer_addresses[x].type_of_address,
                status: customer_addresses[x].status,
                entity: "Building",
                number_and_street: customer_addresses[x].number_and_street,
                suite_or_apartment: customer_addresses[x].suite_or_apartment,
                city: customer_addresses[x].city,
                postal_code: customer_addresses[x].postal_code,
                country: customer_addresses[x].country,
                notes: "No current notes for this address."
            )
            i += 1
            x += 1
        end
        # Address.import! building_addresses

        #Creating customers to be imported
        customers = []
        i = Customer.count + 1
        x = 0
        users.each do
            customers << Customer.new(
                id: i,
                company_name: Faker::Company.name,
                full_name_of_the_company_contact: Faker::Name.name,
                company_contact_phone: Faker::PhoneNumber.phone_number,
                email_of_the_company_contact: users[x].email,
                company_description: Faker::Company.industry,
                full_name_of_service_technical_authority: Faker::Company.name,
                technical_authority_phone_for_Service: Faker::PhoneNumber.phone_number,
                technical_manager_email_for_service: Faker::Internet.unique.safe_email,
                address_id: customer_addresses[x].id,
                user_id: users[x].id
            )
            i += 1
            x += 1
        end
        # Customer.import! customers

        #Creating buildings to be imported
        buildings = []
        i = Building.count + 1
        x = 0
        customers.each do
            buildings << Building.new(
                id: i,
                full_name_of_the_building_administrator: Faker::Name.name,
                email_of_the_administrator_of_the_building: Faker::Internet.unique.safe_email,
                phone_number_of_the_building_administrator: Faker::PhoneNumber.phone_number,
                full_name_of_the_technical_contact_for_the_building: Faker::Name.name,
                echnical_contact_email_for_the_building: Faker::Internet.unique.safe_email,
                rechnical_contact_phone_for_the_building: Faker::PhoneNumber.phone_number,
                address_id: building_addresses[x].id,
                customer_id: customers[x].id,
        )
        i += 1
        x += 1
        end
        # Building.import! buildings

        #Creating batteries to be imported
        batteries = []
        batterie_type = ["Residential", "Commercial", "Corporate", "Hybrid"]
        i = Batterie.count + 1
        x = 0
        buildings.each do
            batteries << Batterie.new(
                id: i,
                Type: batterie_type[Faker::Number.between(from: 0, to: 3)],
                Status: 'online',
                EmployeeId: Faker::Number.between(from: 1, to: Employee.count),
                Date_of_commissioning: Faker::Date.between(from: 3.years.ago, to: Date.today),
                Date_of_last_inspection: Faker::Date.between(from: 3.years.ago, to: Date.today),
                Certificate_of_Operations: Faker::Alphanumeric.alphanumeric(number: 12),
                Information: "Currently online, no issues.",
                Notes: "No current notes.",
                building_id: buildings[x].id
            )
            i += 1
            x += 1
        end
        # Batterie.import! batteries
        
        #Creating columns to be imported
        columns = []
        column_type = ["Residential", "Commercial", "Corporate", "Hybrid"]
        i = Column.count + 1
        x = 0
        batteries.each do
            columns << Column.new(
                id: i,
                Type: column_type[Faker::Number.between(from: 0, to: 3)],
                Number_of_floors: Faker::Number.between(from: 0, to: 60),
                Status: "Online",
                Information: "Currently online, no issues.",
                Notes: "No current notes.",
                batterie_id: batteries[x].id
        )
        i += 1
        x += 1
        end
        # Column.import! columns
        
        #Creating elevators to be imported
        elevators = []
        elevator_model = ["Standard", "Premium", "Excelium"]
        i = Elevator.count + 1
        x = 0
        columns.each do
            elevators << Elevator.new(
                id: i,
                Serial_number: Faker::Alphanumeric.alphanumeric(number: 10),
                Model: elevator_model[Faker::Number.between(from: 0, to: 2)],
                Type: columns[x].Type,
                Status: "Online",
                Date_of_commissioning: Faker::Date.between(from: 3.years.ago, to: Date.today),
                Date_of_last_inspection: Faker::Date.between(from: 3.years.ago, to: Date.today),
                Certificate_of_inspection: Faker::Alphanumeric.alphanumeric(number: 12),
                Information: "Currently online, no issues.",
                Notes: "No current notes.",
                column_id: columns[x].id
        )
        i += 1
        x += 1
        end
        # Elevator.import! elevators

        puts "Importing complete."


    end
end
