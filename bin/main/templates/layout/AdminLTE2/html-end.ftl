<#include "main-footer.ftl">
</div>
<!-- ./wrapper -->

<!-- jQuery 3 -->
<script src="/AdminLTE2/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="/AdminLTE2/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="/AdminLTE2/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="/AdminLTE2/dist/js/adminlte.min.js"></script>
<!-- Sparkline -->
<script src="/AdminLTE2/bower_components/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
<!-- jvectormap  -->
<script src="/AdminLTE2/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="/AdminLTE2/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- SlimScroll -->
<script src="/AdminLTE2/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- ChartJS -->
<script src="/AdminLTE2/bower_components/chart.js/Chart.js"></script>
<!-- date-range-picker -->
<script src="/AdminLTE2/bower_components/moment/min/moment.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->

<!-- AdminLTE for demo purposes -->
<script src="/AdminLTE2/dist/js/demo.js"></script>

<script src="/js/jquery-confirm/jquery-confirm.min.js"></script>
<script src="/js/jquery-fancybox/jquery.fancybox.min.js"></script>
<script src="/js/jquery-redirect/jquery.redirect.js"></script>
<@security.authorize access="isAuthenticated()">
<script src="/js/jwt-client.js"></script>
<script src="/js/jwt-decode.min.js"></script>
</@security.authorize>
</body>
</html>