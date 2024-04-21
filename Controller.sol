// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "../contracts/token/ERC721/IERC721.sol";
import "../contracts/token/ERC20/IERC20.sol";


contract Controller {

    event NftStaking(address nftToken, address nftSender, address nftRecipient, uint256 tokenID, address feeToken, address feeRecipient, uint256 feeAmount);

    event FtStaking(address ftToken, address ftSender, address ftRecipient, uint256 ftAmount, address feeToken, address feeRecipient, uint256 feeAmount);

    event SendMarketFee(address feeToken, address from, address to, uint256 amount);
    

    function nftStaking(address nftToken, address nftSender, address nftRecipient, uint256 tokenID, address feeToken, address feeRecipient, uint256 feeAmount) public virtual {
  
        sendMarketFee(feeToken, nftSender, feeRecipient, feeAmount);
        
        IERC721(nftToken).safeTransferFrom(nftSender, nftRecipient, tokenID);

        emit NftStaking(nftToken, nftSender, nftRecipient, tokenID, feeToken, feeRecipient, feeAmount);
 
    }
    

    function ftStaking(address ftToken, address ftSender, address ftRecipient, uint256 ftAmount, address feeToken, address feeRecipient, uint256 feeAmount) public virtual {
  
        sendMarketFee(feeToken, ftSender, feeRecipient, feeAmount);
        
        IERC20(ftToken).transferFrom(ftSender, ftRecipient, ftAmount);

        emit FtStaking(ftToken, ftSender, ftRecipient, ftAmount, feeToken, feeRecipient, feeAmount);
 
    }
   

    function sendMarketFee(address feeToken, address from, address to, uint256 amount) public {
  
        IERC20(feeToken).transferFrom(from, to, amount);

        emit SendMarketFee(feeToken, from, to, amount);
         
    }
   
}