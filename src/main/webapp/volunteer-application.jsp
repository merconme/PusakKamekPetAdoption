<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Medical Database</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #7a0019; margin: 0; padding: 20px; color: #333; }
        .container { max-width: 1000px; margin: 0 auto; background: #fdf0f1; padding: 30px; border-radius: 40px; min-height: 80vh; }
        
        .header { text-align: center; margin-bottom: 20px; }
        .header h1 { color: #7a0019; margin: 0; }
        .back-btn { text-decoration: none; color: #d67a8b; font-weight: bold; display: block; margin-bottom: 10px; }

        /* Pet Type Switcher */
        .type-switcher { display: flex; justify-content: center; gap: 10px; margin-bottom: 25px; }
        .filter-btn { 
            padding: 10px 20px; 
            border-radius: 20px; 
            border: 2px solid #7a0019; 
            background: white; 
            color: #7a0019; 
            cursor: pointer; 
            font-weight: bold; 
            transition: 0.3s;
        }
        .filter-btn.active { background: #7a0019; color: white; }

        /* Search Styles */
        .search-box { display: flex; gap: 10px; margin-bottom: 30px; justify-content: center; }
        .search-box input { padding: 12px 20px; width: 300px; border-radius: 20px; border: 2px solid #7a0019; outline: none; }

        /* Record Cards */
        .pet-record { background: white; border-radius: 20px; padding: 20px; margin-bottom: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); border-left: 10px solid #d67a8b; transition: 0.3s; }
        .pet-record.highlight { border-left-color: #7a0019; transform: scale(1.01); }
        
        .pet-info { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #eee; padding-bottom: 10px; margin-bottom: 15px; }
        .pet-info h2 { margin: 0; color: #7a0019; }
        .species-tag { font-size: 12px; background: #eee; padding: 4px 10px; border-radius: 10px; color: #666; font-weight: bold; text-transform: uppercase; }

        table { width: 100%; border-collapse: collapse; }
        th, td { text-align: left; padding: 10px; font-size: 14px; }
        th { color: #888; text-transform: uppercase; font-size: 11px; }
        .status { font-weight: bold; color: #27ae60; }
        .pending { color: #f39c12; }

        #noRecords { text-align: center; display: none; padding: 50px; color: #7a0019; }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <a href="petbrowse.jsp" class="back-btn">← Back to Gallery</a>
        <h1>Medical Database</h1>
        <p>Vaccination & Immunization Tracking</p>
    </div>

    <div class="type-switcher">
        <button class="filter-btn active" onclick="filterSpecies('all', this)">All Pets</button>
        <button class="filter-btn" onclick="filterSpecies('cat', this)">Cats</button>
        <button class="filter-btn" onclick="filterSpecies('dog', this)">Dogs</button>
        <button class="filter-btn" onclick="filterSpecies('rabbit', this)">Rabbits</button>
        <button class="filter-btn" onclick="filterSpecies('hamster', this)">Hamsters</button>
    </div>

    <div class="search-box">
        <input type="text" id="recordSearch" placeholder="Search by name..." onkeyup="runAllFilters()">
    </div>

    <div id="recordsList">
        <%-- Static records, can be replaced with dynamic JSTL/Servlet fetch later --%>
        <div class="pet-record" data-name="luna" data-species="cat">
            <div class="pet-info">
                <h2>Luna <span class="species-tag">Cat</span></h2>
                <span>Domestic Short Hair • Kitten</span>
            </div>
            <table>
                <tr><th>Vaccine</th><th>Date</th><th>Status</th></tr>
                <tr><td>FVRCP (Core)</td><td>Oct 2025</td><td class="status">Completed</td></tr>
                <tr><td>Rabies</td><td>Oct 2025</td><td class="status">Completed</td></tr>
            </table>
        </div>
        <div class="pet-record" data-name="buddy" data-species="dog">
            <div class="pet-info">
                <h2>Buddy <span class="species-tag">Dog</span></h2>
                <span>Golden Retriever • Adult</span>
            </div>
            <table>
                <tr><th>Vaccine</th><th>Date</th><th>Status</th></tr>
                <tr><td>DHPP</td><td>Nov 2025</td><td class="status">Completed</td></tr>
                <tr><td>Rabies</td><td>Nov 2025</td><td class="status">Completed</td></tr>
                <tr><td>Bordetella</td><td>Nov 2025</td><td class="status">Completed</td></tr>
            </table>
        </div>
        <div class="pet-record" data-name="thumper" data-species="rabbit">
            <div class="pet-info">
                <h2>Thumper <span class="species-tag">Rabbit</span></h2>
                <span>Holland Lop • Adult</span>
            </div>
            <table>
                <tr><th>Vaccine</th><th>Date</th><th>Status</th></tr>
                <tr><td>RVHD</td><td>Sep 2025</td><td class="status">Completed</td></tr>
                <tr><td>Myxomatosis</td><td>-</td><td class="pending">Scheduled (Feb 2026)</td></tr>
            </table>
        </div>
        <div class="pet-record" data-name="pip" data-species="hamster">
            <div class="pet-info">
                <h2>Pip <span class="species-tag">Hamster</span></h2>
                <span>Syrian Hamster • Juvenile</span>
            </div>
            <p style="padding: 10px; font-style: italic; color: #666;">Note: Hamsters do not require routine vaccinations, but undergo monthly wellness checks.</p>
            <table>
                <tr><th>Checkup Type</th><th>Date</th><th>Status</th></tr>
                <tr><td>General Wellness</td><td>Jan 2026</td><td class="status">Completed</td></tr>
            </table>
        </div>
    </div>

    <div id="noRecords">
        <h3>No medical records found.</h3>
    </div>
</div>

<script>
    let activeSpecies = 'all';

    function filterSpecies(species, btn) {
        const buttons = document.getElementsByClassName('filter-btn');
        for (let b of buttons) b.classList.remove('active');
        btn.classList.add('active');

        activeSpecies = species;
        runAllFilters();
    }

    function runAllFilters() {
        const nameQuery = document.getElementById('recordSearch').value.toLowerCase();
        const records = document.getElementsByClassName('pet-record');
        let found = false;

        for (let record of records) {
            const name = record.getAttribute('data-name');
            const species = record.getAttribute('data-species');
            
            const matchesSpecies = (activeSpecies === 'all' || species === activeSpecies);
            const matchesName = name.includes(nameQuery);

            if (matchesSpecies && matchesName) {
                record.style.display = "block";
                found = true;
            } else {
                record.style.display = "none";
            }
        }
        document.getElementById('noRecords').style.display = found ? "none" : "block";
    }
</script>

</body>
</html>
