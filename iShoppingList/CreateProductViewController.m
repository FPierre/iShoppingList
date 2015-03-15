//
//  CreateProductViewController.m
//  iShoppingList
//
//  Created by Save92 on 13/03/2015.
//  Copyright (c) 2015 Nicolas Save. All rights reserved.
//

#import "CreateProductViewController.h"

@interface CreateProductViewController ()

@end

@implementation CreateProductViewController

@synthesize product = product_;
@synthesize delegate = delegate_;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"New Product";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.product) {
        self.nameTextfield.text = self.product.name;
        NSString* price = [NSString stringWithFormat:@"%f", self.product.price];
        self.priceTextfield.text = price;
        NSString* quantity = [NSString stringWithFormat:@"%lu", (unsigned long)self.product.quantity];
        self.quantityTextfield.text = quantity;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// TODO: faire une vrai gestion d'erreur
// TODO: remplacer le token User en dur dans l'URL
// TODO: remplacer l'Id ShoppingList en dur dans l'URL
- (IBAction)onTouchAdd:(id)sender {
    if (!self.product) {
        //@TODO voir comment recuperer le token et l'id de la liste
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://appspaces.fr/esgi/shopping_list/product/create.php?token=%@&shopping_list_id=%@&name=%@&quantity=%lu&price=%f", @"161e936338febc2edc95214098db81a1", @"0", self.product.name, self.product.quantity, self.product.price]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        if (!error) {
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
            NSString *codeReturn = [jsonDict objectForKey:@"code"];
            
            if ([codeReturn isEqualToString:@"0"]) {
                Product *newProduct = [Product new];
                NSDictionary *result = [jsonDict objectForKey:@"result"];
                
                newProduct.name = [result objectForKey:@"name"];
                
                if ([self.delegate respondsToSelector:@selector(createProductViewControllerDidCreateProduct:)]) {
                    [self.delegate createProductViewControllerDidCreateProduct:newProduct];
                }
            }
        }
    }
}

@end
