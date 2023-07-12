from torchvision import models
from ptflops import get_model_complexity_info


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    resnet18 = models.resnet18(pretrained=True)
    macs, params = get_model_complexity_info(resnet18, (3, 255, 255), as_strings=False, print_per_layer_stat=True,
                                             verbose=True)
    print('{:<30}  {:<8}'.format('Computational complexity: ', macs))
    print('{:<30}  {:<8}'.format('Number of parameters: ', params))
    resnet34 = models.resnet34(pretrained=True)
    macs, params = get_model_complexity_info(resnet34, (3, 255, 255), as_strings=False, print_per_layer_stat=True,
                                             verbose=True)
    print('{:<30}  {:<8}'.format('Computational complexity: ', macs))
    print('{:<30}  {:<8}'.format('Number of parameters: ', params))
    resnet50 = models.resnet50(pretrained=True)
    macs, params = get_model_complexity_info(resnet50, (3, 255, 255), as_strings=False, print_per_layer_stat=True,
                                             verbose=True)
    print('{:<30}  {:<8}'.format('Computational complexity: ', macs))
    print('{:<30}  {:<8}'.format('Number of parameters: ', params))
    # print(resnet)


# See PyCharm help at https://www.jetbrains.com/help/pycharm/
