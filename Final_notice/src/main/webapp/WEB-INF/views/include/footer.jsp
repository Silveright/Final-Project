<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
footer {
width : 100%;
margin-top:100px;
}
</style>
<!-- Start Footer -->
<footer class="bg pt-4" style="background-color: #6266eab8!important;">
    <div class="container">
        <div class="row py-4">

            <div class="col-lg-3 col-12 align-left">
                <a class="navbar-brand" href="#">
                    <p class="text-light h3 text-wrap">3.3.5.5</p>
                </a>
                <p class="text-light my-lg-4 my-2">

                </p>
                <ul class="list-inline footer-icons light-300">
                    <li class="list-inline-item m-0">
                        <a class="text-light" target="_blank" href="http://facebook.com/">
                            <i class='bx bxl-facebook-square bx-md'></i>
                        </a>
                    </li>
                    <li class="list-inline-item m-0">
                        <a class="text-light" target="_blank" href="https://www.linkedin.com/">
                            <i class='bx bxl-linkedin-square bx-md'></i>
                        </a>
                    </li>
                    <li class="list-inline-item m-0">
                        <a class="text-light" target="_blank" href="https://www.whatsapp.com/">
                            <i class='bx bxl-whatsapp-square bx-md'></i>
                        </a>
                    </li>
                    <li class="list-inline-item m-0">
                        <a class="text-light" target="_blank" href="https://www.flickr.com/">
                            <i class='bx bxl-flickr-square bx-md'></i>
                        </a>
                    </li>
                    <li class="list-inline-item m-0">
                        <a class="text-light" target="_blank" href="https://www.medium.com/">
                            <i class='bx bxl-medium-square bx-md'></i>
                        </a>
                    </li>
                </ul>
            </div>

            <div class="col-lg-3 col-md-4 my-sm-0 mt-4">
                <h2 class="h4 pb-lg-3 text-light light-300">Site Map</h2>
                <ul class="list-unstyled text-light light-300">
                    <li class="pb-2">
                        <i class='bx-fw bx bxs-chevron-right bx-xs'></i><a class="text-decoration-none text-light"
                                                                           href="/test/main/list">Home</a>
                    </li>
                    <li class="pb-2">
                        <i class='bx-fw bx bxs-chevron-right bx-xs'></i><a class="text-decoration-none text-light py-1"
                                                                           href="/test/member/join">Join</a>
                    </li>
                    <li class="pb-2">
                        <i class='bx-fw bx bxs-chevron-right bx-xs'></i><a class="text-decoration-none text-light py-1"
                                                                           href="/test/admin/noticelist"><small>공지사항</small></a>
                    </li>
                    <li class="pb-2">
                        <i class='bx-fw bx bxs-chevron-right bx-xs'></i><a class="text-decoration-none text-light py-1"
                                                                           href="/test/admin/inquiry"><small>문의사항</small></a>
                    </li>
                </ul>
            </div>

            <div class="col-lg-3 col-md-4 my-sm-0 mt-4">
                <h2 class="h4 pb-lg-3 text-light light-300">Our Works</h2>
                <ul class="list-unstyled text-light light-300">
                    <li class="pb-2">
                        <i class='bx-fw bx bxs-chevron-right bx-xs'></i><a class="text-decoration-none text-light py-1"
                                                                           href="#">개인정보처리방침</a>
                    </li>
                    <li class="pb-2">
                        <i class='bx-fw bx bxs-chevron-right bx-xs'></i><a class="text-decoration-none text-light py-1"
                                                                           href="#">이메일무단수집거부</a>
                    </li>
                    <li class="pb-2">
                        <i class='bx-fw bx bxs-chevron-right bx-xs'></i><a class="text-decoration-none text-light py-1"
                                                                           href="#">책임의 한계와 법적고지</a>
                    </li>
                </ul>
            </div>

            <div class="col-lg-3 col-md-4 my-sm-0 mt-4">
                <h2 class="h4 pb-lg-3 text-light light-300">Our Members</h2>
                <ul class="list-unstyled text-light light-300">
                    <li class="pb-2">
                        <i class='bx-fw bx bx-mail-send bx-xs'></i>김덕규><a class="text-decoration-none text-light py-1">ejrrb91@gmail.com</a><br>
                        <i class='bx-fw bx bx-mail-send bx-xs'></i>진봉수><a class="text-decoration-none text-light py-1">jbs107601@gmail.com</a><br>
                        <i class='bx-fw bx bx-mail-send bx-xs'></i>최민준><a class="text-decoration-none text-light py-1">spyparty66@gmail.com</a><br>
                        <i class='bx-fw bx bx-mail-send bx-xs'></i>황은정><a class="text-decoration-none text-light py-1">dlswjd1118@gmail.com</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</footer>
<!-- End Footer -->
<!-- Page Script -->
<script>
    //window.load
    $(function () {
        $('#searchSelect').niceSelect();
        // init Isotope
        var $projects = $('.projects').isotope({
            itemSelector: '.project',
            layoutMode: 'fitRows'
        });
        $(".filter-btn").click(function () {
            var data_filter = $(this).attr("data-filter");
            $projects.isotope({
                filter: data_filter
            });
            $(".filter-btn").removeClass("active");
            $(".filter-btn").removeClass("shadow");
            $(this).addClass("active");
            $(this).addClass("shadow");
            return false;
        });
        

    });
        var id = $("#loginid").text();
        console.log(id);
        $("#userid").val(id);
</script>
