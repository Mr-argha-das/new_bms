import 'package:admin/screens/allocation/model/Allocation.add.model.dart';
import 'package:admin/screens/allocation/model/allocation.add.res.dart';
import 'package:admin/screens/allocation/view/add.allocation.dart';
import 'package:admin/screens/allocation/view/allocation.list.dart';
import 'package:admin/screens/orders/model/allocation.model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'allocation.service.g.dart';

@RestApi(baseUrl: 'https://squid-app-3-s689g.ondigitalocean.app')
abstract class AllocationSerive{
  factory AllocationSerive(Dio dio) = _AllocationSerive;

  @POST('/allocation-create')
  Future<AllocationAddResponse> addAllocation(@Body() AllocationAddModel body);
  @GET('/allocation-list')
  Future<AllocationListmodel> getAllocationList();
  @PUT('/allocation-update/{id}')
  Future<AllocationAddResponse> upadteAllocation(@Path('id') String id, @Body() AllocationUpdateModel body);
}