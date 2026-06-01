<%@ Page Title="Instructor Dashboard" Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Aidify_assigment.Instructor.Dashboard" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Aidify - Instructor Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            margin: 0;
            background-color: #fff8f7;
            color: #121c2c;
            font-family: Arial, sans-serif;
        }

        .instructor-shell {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background-color: #fff8f7;
        }

        .topbar {
            min-height: 76px;
            background: #ffffff;
            border-bottom: 1px solid #e6bdb8;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 34px;
            position: sticky;
            top: 0;
            z-index: 50;
            gap: 20px;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 26px;
            font-weight: 800;
            color: #b70011;
            white-space: nowrap;
        }

        .role-badge {
            background: #b70011;
            color: white;
            font-size: 11px;
            padding: 4px 10px;
            border-radius: 20px;
            text-transform: uppercase;
            letter-spacing: .5px;
        }

        .top-links {
            display: flex;
            gap: 18px;
            align-items: center;
            flex-wrap: wrap;
            justify-content: center;
        }

        .top-links a {
            color: #5c403c;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }

        .top-links a.active {
            color: #b70011;
            border-bottom: 2px solid #b70011;
            padding-bottom: 8px;
        }

        .profile {
            display: flex;
            align-items: center;
            gap: 12px;
            white-space: nowrap;
        }

        .avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: #b70011;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            overflow: hidden;
            border: 1px solid #e6bdb8;
        }

        .profile-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .layout {
            display: flex;
            flex: 1;
        }

        .sidebar {
            width: 260px;
            min-height: calc(100vh - 76px);
            background: #ffffff;
            border-right: 1px solid #e6bdb8;
            padding: 28px 18px;
            position: sticky;
            top: 76px;
        }

        .sidebar-heading {
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #916f6b;
            font-weight: 800;
            margin: 18px 12px 10px;
        }

        .side-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 13px 15px;
            border-radius: 10px;
            color: #5c403c;
            text-decoration: none;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .side-link:hover {
            background: #fff1ef;
            color: #b70011;
        }

        .side-link.active {
            background: #b70011;
            color: white;
        }

        .help-box {
            background: #b70011;
            color: white;
            border-radius: 18px;
            padding: 22px;
            margin-top: 35px;
        }

        .help-box h6 {
            font-weight: 800;
            margin-bottom: 8px;
        }

        .help-box p {
            font-size: 14px;
            opacity: .9;
            margin-bottom: 14px;
        }

        .help-box button {
            width: 100%;
            border: none;
            background: white;
            color: #b70011;
            border-radius: 8px;
            padding: 8px 14px;
            font-weight: 800;
        }

        .main {
            flex: 1;
            padding: 42px 48px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: end;
            gap: 20px;
            margin-bottom: 28px;
        }

        .page-header h1 {
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 6px;
        }

        .page-header p {
            color: #545f72;
            margin: 0;
        }

        .btn-aidify {
            background: #b70011;
            color: white;
            border: 1px solid #b70011;
            font-weight: 700;
            border-radius: 8px;
            padding: 10px 16px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-aidify:hover {
            background: #8b000a;
            color: white;
        }

        .btn-outline-aidify {
            background: white;
            color: #5c403c;
            border: 1px solid #e6bdb8;
            font-weight: 700;
            border-radius: 8px;
            padding: 10px 16px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-outline-aidify:hover {
            background: #fff1ef;
            color: #b70011;
        }

        .stat-card {
            background: white;
            border: 1px solid #e6bdb8;
            border-radius: 16px;
            padding: 22px;
            height: 100%;
            transition: .2s ease;
        }

        .stat-card:hover {
            border-color: #b70011;
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(183,0,17,.08);
        }

        .stat-icon {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            background: #ffdad6;
            color: #b70011;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            margin-bottom: 14px;
        }

        .stat-number {
            font-size: 30px;
            font-weight: 800;
        }

        .stat-label {
            color: #545f72;
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: .7px;
        }

        .dashboard-card {
            background: white;
            border: 1px solid #e6bdb8;
            border-radius: 16px;
            padding: 25px;
        }

        .card-header-custom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 22px;
        }

        .modules-table th {
            background: #fff8f7;
            color: #916f6b;
            font-size: 12px;
            text-transform: uppercase;
            padding: 15px;
            border-bottom: 1px solid #e6bdb8;
        }

        .modules-table td {
            padding: 16px;
            vertical-align: middle;
            border-bottom: 1px solid #f1d6d2;
        }

        .module-thumb {
            width: 42px;
            height: 42px;
            border-radius: 10px;
            object-fit: cover;
            margin-right: 10px;
            border: 1px solid #e6bdb8;
        }

        .badge-easy, .badge-medium, .badge-hard,
        .badge-draft, .badge-pending, .badge-published {
            padding: 5px 9px;
            border-radius: 14px;
            font-size: 12px;
            font-weight: 800;
            display: inline-block;
        }

        .badge-easy {
            background: #d8f3e7;
            color: #198754;
        }

        .badge-medium {
            background: #fff3cd;
            color: #9a6a00;
        }

        .badge-hard {
            background: #ffe1e4;
            color: #b70011;
        }

        .badge-draft {
            background: #eeeeee;
            color: #545f72;
            border: 1px solid #d7d7d7;
        }

        .badge-pending {
            background: #fff3cd;
            color: #9a6a00;
            border: 1px solid #eed48a;
        }

        .badge-published {
            background: #d8f3e7;
            color: #198754;
            border: 1px solid #9bd9b8;
        }

        .action-link {
            color: #545f72;
            text-decoration: none;
            margin-left: 10px;
            font-size: 18px;
        }

        .action-link:hover {
            color: #b70011;
        }

        .chart-box {
            background: #fff8f7;
            height: 230px;
            border-radius: 14px;
            padding: 35px 28px 20px;
            display: flex;
            align-items: end;
            gap: 18px;
        }

        .chart-bar {
            flex: 1;
            background: #b70011;
            border-radius: 6px 6px 0 0;
            opacity: .85;
        }

        .chart-days {
            display: flex;
            justify-content: space-between;
            padding: 12px 20px 0;
            color: #545f72;
            font-size: 12px;
            font-weight: 700;
        }

        .activity-item {
            display: flex;
            gap: 14px;
            padding: 13px 0;
            border-bottom: 1px solid #f1d6d2;
        }

        .activity-line {
            width: 4px;
            border-radius: 10px;
            min-height: 44px;
            flex-shrink: 0;
        }

        .activity-line.red {
            background: #b70011;
        }

        .activity-line.blue {
            background: #0d47a1;
        }

        .activity-line.gray {
            background: #8d6e63;
        }

        .activity-item p {
            margin: 0;
            font-size: 14px;
        }

        .activity-item small {
            color: #545f72;
        }

        @media (max-width: 1200px) {
            .top-links {
                gap: 12px;
            }

            .top-links a {
                font-size: 13px;
            }
        }

        @media (max-width: 992px) {
            .sidebar {
                display: none;
            }

            .main {
                padding: 28px 20px;
            }

            .top-links {
                display: none;
            }

            .page-header {
                flex-direction: column;
                align-items: start;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="instructor-shell">

            <div class="topbar">
                <div class="brand">
                    Aidify
                    <span class="role-badge">Instructor</span>
                </div>

                <div class="top-links">
                    <a href="Dashboard.aspx" class="active">Dashboard</a>
                    <a href="Modules/List.aspx">Modules</a>
                    <a href="Lessons/List.aspx">Lessons</a>
                    <a href="Materials/Upload.aspx">Materials</a>
                    <a href="Quizzes/List.aspx">Quizzes</a>
                    <a href="Performance.aspx">Performance</a>
                    <a href="Challenges.aspx">Challenges</a>
                    <a href="Events.aspx">Events</a>
                </div>

                <div class="profile">
                    <div class="text-end d-none d-md-block">
                        <div class="fw-bold">Dr. Smith</div>
                        <small class="text-muted">Instructor</small>
                    </div>

                    <div class="avatar">
                        <img class="profile-img"
                             alt="Instructor Profile"
                             src="https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?auto=format&fit=crop&w=160&q=80"
                             onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1582750433449-648ed127bb54?auto=format&fit=crop&w=160&q=80';" />
                    </div>
                </div>
            </div>

            <div class="layout">
                <aside class="sidebar">
                    <div class="sidebar-heading">Main Menu</div>

                    <a href="Dashboard.aspx" class="side-link active">
                        <i class="bi bi-grid"></i> Dashboard
                    </a>

                    <a href="Modules/List.aspx" class="side-link">
                        <i class="bi bi-journal-bookmark"></i> Modules
                    </a>

                    <a href="Lessons/List.aspx" class="side-link">
                        <i class="bi bi-book"></i> Lessons
                    </a>

                    <a href="Materials/Upload.aspx" class="side-link">
                        <i class="bi bi-folder2-open"></i> Materials
                    </a>

                    <a href="Quizzes/List.aspx" class="side-link">
                        <i class="bi bi-ui-checks"></i> Quizzes
                    </a>

                    <div class="sidebar-heading">Monitoring</div>

                    <a href="Performance.aspx" class="side-link">
                        <i class="bi bi-graph-up"></i> Performance
                    </a>

                    <a href="Discussions.aspx" class="side-link">
                        <i class="bi bi-chat-dots"></i> Discussions
                    </a>

                    <a href="Challenges.aspx" class="side-link">
                        <i class="bi bi-trophy"></i> Challenges
                    </a>

                    <a href="Events.aspx" class="side-link">
                        <i class="bi bi-calendar-event"></i> Events
                    </a>

                    <div class="help-box">
                        <h6><i class="bi bi-question-circle me-2"></i>Need Help?</h6>
                        <p>Check the instructor guide for help with course creation.</p>
                        <button type="button" onclick="showToast('Instructor guide will be added later.')">Read Guide</button>
                    </div>
                </aside>

                <main class="main">
                    <div class="page-header">
                        <div>
                            <h1>Instructor Dashboard</h1>
                            <p>Manage emergency response curriculum and monitor learner progression.</p>
                        </div>

                        <div class="d-flex gap-2 flex-wrap">
                            <a href="Modules/Edit.aspx" class="btn-aidify">
                                <i class="bi bi-plus-lg"></i> New Module
                            </a>

                            <a href="Performance.aspx" class="btn-outline-aidify">
                                <i class="bi bi-download"></i> Export Report
                            </a>
                        </div>
                    </div>

                    <div class="row g-4 mb-4">
                        <div class="col-md-6 col-lg-3">
                            <div class="stat-card">
                                <div class="stat-icon"><i class="bi bi-journal-bookmark"></i></div>
                                <div class="stat-number">24</div>
                                <div class="stat-label">Total Modules</div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="stat-card">
                                <div class="stat-icon"><i class="bi bi-pencil-square"></i></div>
                                <div class="stat-number">8</div>
                                <div class="stat-label">Drafts</div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="stat-card">
                                <div class="stat-icon"><i class="bi bi-hourglass-split"></i></div>
                                <div class="stat-number">3</div>
                                <div class="stat-label">Pending Review</div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="stat-card">
                                <div class="stat-icon"><i class="bi bi-check-circle"></i></div>
                                <div class="stat-number">13</div>
                                <div class="stat-label">Published</div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="stat-card">
                                <div class="stat-icon"><i class="bi bi-ui-checks"></i></div>
                                <div class="stat-number">42</div>
                                <div class="stat-label">Quizzes</div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="stat-card">
                                <div class="stat-icon"><i class="bi bi-chat-dots"></i></div>
                                <div class="stat-number">12</div>
                                <div class="stat-label">Unread Discussions</div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="stat-card">
                                <div class="stat-icon"><i class="bi bi-trophy"></i></div>
                                <div class="stat-number">8</div>
                                <div class="stat-label">Challenges</div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="stat-card">
                                <div class="stat-icon"><i class="bi bi-calendar-event"></i></div>
                                <div class="stat-number">6</div>
                                <div class="stat-label">Events</div>
                            </div>
                        </div>
                    </div>

                    <div class="dashboard-card mb-4">
                        <div class="card-header-custom">
                            <h2 class="h5 fw-bold">Recent Modules</h2>
                            <a href="Modules/List.aspx" class="text-danger fw-bold text-decoration-none">View All Modules</a>
                        </div>

                        <div class="table-responsive">
                            <table class="table modules-table">
                                <thead>
                                    <tr>
                                        <th>Title</th>
                                        <th>Difficulty</th>
                                        <th>Status</th>
                                        <th class="text-center">Lessons</th>
                                        <th class="text-center">Learners</th>
                                        <th class="text-end">Actions</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <tr>
                                        <td>
                                            <img class="module-thumb"
                                                 alt="Advanced Life Support"
                                                 src="https://images.unsplash.com/photo-1584515933487-779824d29309?auto=format&fit=crop&w=120&q=80" />
                                            <span>
                                                <strong>Advanced Life Support (ALS)</strong><br />
                                                <small class="text-muted">Updated 2 days ago</small>
                                            </span>
                                        </td>
                                        <td><span class="badge-hard">Hard</span></td>
                                        <td><span class="badge-published">Published</span></td>
                                        <td class="text-center">12</td>
                                        <td class="text-center">1,240</td>
                                        <td class="text-end">
                                            <a href="Modules/Edit.aspx" class="action-link"><i class="bi bi-pencil"></i></a>
                                            <a href="Lessons/List.aspx" class="action-link"><i class="bi bi-three-dots-vertical"></i></a>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <img class="module-thumb"
                                                 alt="Basic Wound Care"
                                                 src="https://images.unsplash.com/photo-1583947215259-38e31be8751f?auto=format&fit=crop&w=120&q=80" />
                                            <span>
                                                <strong>Basic Wound Care Protocols</strong><br />
                                                <small class="text-muted">Updated 5 days ago</small>
                                            </span>
                                        </td>
                                        <td><span class="badge-easy">Easy</span></td>
                                        <td><span class="badge-published">Published</span></td>
                                        <td class="text-center">5</td>
                                        <td class="text-center">3,150</td>
                                        <td class="text-end">
                                            <a href="Modules/Edit.aspx" class="action-link"><i class="bi bi-pencil"></i></a>
                                            <a href="Lessons/List.aspx" class="action-link"><i class="bi bi-three-dots-vertical"></i></a>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <img class="module-thumb"
                                                 alt="Pediatric Emergency Response"
                                                 src="https://images.unsplash.com/photo-1576765608535-5f04d1e3f289?auto=format&fit=crop&w=120&q=80" />
                                            <span>
                                                <strong>Pediatric Emergency Response</strong><br />
                                                <small class="text-muted">Draft saved 1 hour ago</small>
                                            </span>
                                        </td>
                                        <td><span class="badge-medium">Medium</span></td>
                                        <td><span class="badge-draft">Draft</span></td>
                                        <td class="text-center">8</td>
                                        <td class="text-center">0</td>
                                        <td class="text-end">
                                            <a href="Modules/Edit.aspx" class="action-link"><i class="bi bi-pencil"></i></a>
                                            <a href="Lessons/List.aspx" class="action-link"><i class="bi bi-three-dots-vertical"></i></a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="row g-4">
                        <div class="col-lg-6">
                            <div class="dashboard-card">
                                <div class="card-header-custom">
                                    <h3 class="h5 fw-bold">
                                        <i class="bi bi-graph-up text-danger me-2"></i>Learner Engagement
                                    </h3>

                                    <select class="form-select w-auto">
                                        <option>Last 7 Days</option>
                                        <option>Last 30 Days</option>
                                    </select>
                                </div>

                                <div class="chart-box">
                                    <div class="chart-bar" style="height: 28%;"></div>
                                    <div class="chart-bar" style="height: 45%;"></div>
                                    <div class="chart-bar" style="height: 62%;"></div>
                                    <div class="chart-bar" style="height: 100%;"></div>
                                    <div class="chart-bar" style="height: 82%;"></div>
                                    <div class="chart-bar" style="height: 64%;"></div>
                                    <div class="chart-bar" style="height: 50%;"></div>
                                </div>

                                <div class="chart-days">
                                    <span>MON</span>
                                    <span>TUE</span>
                                    <span>WED</span>
                                    <span>THU</span>
                                    <span>FRI</span>
                                    <span>SAT</span>
                                    <span>SUN</span>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="dashboard-card">
                                <div class="card-header-custom">
                                    <h3 class="h5 fw-bold">
                                        <i class="bi bi-bell text-danger me-2"></i>Recent Activity
                                    </h3>
                                </div>

                                <div class="activity-item">
                                    <div class="activity-line red"></div>
                                    <div>
                                        <p><strong>John Doe</strong> completed “Advanced Life Support”.</p>
                                        <small>15 minutes ago</small>
                                    </div>
                                </div>

                                <div class="activity-item">
                                    <div class="activity-line blue"></div>
                                    <div>
                                        <p>New discussion in <strong class="text-danger">Pediatric Response</strong>.</p>
                                        <small>1 hour ago</small>
                                    </div>
                                </div>

                                <div class="activity-item">
                                    <div class="activity-line gray"></div>
                                    <div>
                                        <p><strong>Admin</strong> published “Basic Wound Care”.</p>
                                        <small>3 hours ago</small>
                                    </div>
                                </div>

                                <div class="activity-item">
                                    <div class="activity-line red"></div>
                                    <div>
                                        <p><strong>Sarah Jenkins</strong> joined your “ALS” module.</p>
                                        <small>5 hours ago</small>
                                    </div>
                                </div>

                                <div class="activity-item">
                                    <div class="activity-line blue"></div>
                                    <div>
                                        <p>New learner challenge created: <strong class="text-danger">AED Safety Challenge</strong>.</p>
                                        <small>Today</small>
                                    </div>
                                </div>

                                <div class="activity-item">
                                    <div class="activity-line gray"></div>
                                    <div>
                                        <p>Upcoming event scheduled: <strong class="text-danger">CPR Practical Workshop</strong>.</p>
                                        <small>Today</small>
                                    </div>
                                </div>

                                <div class="text-center mt-3">
                                    <a href="#" class="text-danger fw-bold text-decoration-none">View All Activity</a>
                                </div>
                            </div>
                        </div>
                    </div>

                </main>
            </div>
        </div>

        <div id="toastUi" class="toast-ui" style="position: fixed; right: 24px; bottom: 24px; background: #121c2c; color: white; border-radius: 12px; padding: 14px 18px; display: none; z-index: 1000; box-shadow: 0 12px 30px rgba(0,0,0,0.18); font-weight: 700;"></div>

        <script>
            function showToast(message) {
                var toast = document.getElementById("toastUi");

                if (!toast) {
                    alert(message);
                    return;
                }

                toast.innerText = message;
                toast.style.display = "block";

                setTimeout(function () {
                    toast.style.display = "none";
                }, 2600);
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>