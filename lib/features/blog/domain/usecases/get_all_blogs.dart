import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repositories.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoPrams> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(NoPrams params) async {
    return await blogRepository.getAllBlogs();
  }
}
