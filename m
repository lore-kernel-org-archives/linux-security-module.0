Return-Path: <SRS0=wNUX=P2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720F7C07EBF
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 18:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4063520850
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 18:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rcBO7XyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfARStL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:49:11 -0500
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:38747
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728603AbfARStL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 Jan 2019 13:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547837350; bh=SN7Wup0I7RwIrPvBYe3S2icYrQXJiSR/7u+RkxAaQCk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=rcBO7XyW8tTMCPnbejenqMWtzeMxFTTxS0X1bPJRg4A8mX2waVd0C34zz9pciFI6qatA6hSjYZVuq9sg/So8wLjCreUdF+oiGv5fe1Uu3ml8Xirn1i8PnlwLBqB0zrvY3LMN0BBcEcncHet6qYkn8d6ksrY9F9zT56NTbEuA/k4Syeq3Nh0SWkN87zhHTeVNJA1uE1hAYyyy88Y5oec8PMW+S4kzTVsdhfRQVrajuS7gCQdIniq6Ogi2MAavJ10sAoiJLvT3pIv1TevruLf7SijFIvVqcCyBEwxJPpSpsVLwozmOTnMagFscnNbSKQjnNDuQHjGY2RT5+hNecBMibg==
X-YMail-OSG: yD_609MVM1kU5pyDL5lCD7aRkw_U88efooRMI2rCcFGtwatcWjrWofelULfdUts
 Ndujngd1N_HggYt_D4UnSy7E6e3uMnoyRHFPhvKmfx2pGZZohtFmTl0VJAMrH1RSioJ6cO9dPkPl
 z93ag.vPnumuSH6ukUqOfT9ffRs8dGbnXSW1Y17Ikri6PopjmqJdXit1JCx70f.ZAMMnP6Mv8UQ1
 q1vCGc9Tlov6Is5fsgv33PgnrI6N7NinfWTinyxh0tQFUqp.N6zlgC2rOLpohOjj3vD.YrCHcdoW
 fip8l_gToK1Qh2RvimzmKU33xvaa_cPA0lY8yDIfp1xBLwGVcM4kzwrX9HBSQ3nsYL5yvl914V2D
 zk5TcBJ5oRsh.dEX4wEGu3P1UOBq0uVve4yXT9rqyIERZUGCi8h33V1vbZTCYe66l7snDBsiNdMn
 RFHO8i_s6Yhc12j8cMBY6DOuG9EDxXX4jrEacE6VRyGeJFbZrhD1Fc1bg3mOGaOp4wEddLRR0w8P
 DveKE7dIKvOyj0g3VGAvNh1nBwe52yO66P4LXCPRp3b1CBZs6JCO4LlT5dR4T5qluUH76Wx3oGC6
 aD8NoKbLa_yj_dhqLHGPKN9_JOq5s9HxHeO3bfVWQW6NLeeX3A3BN.RcThzFA3K6QGxukfzrtv3w
 hG5gjUToWgJZBw09KZOCNx1lhQd_WXobJqnT3RGkSD1ZfcaVcTgkPUU8fBXCIDR_uW5AeySOQbtP
 3GJgNLEwkf0gccmfkKJMjrVvNwTkWlLFKQb03CdR7G4HjqcT7J16VdWJIYCQoeIuuPHDwNegruFO
 GM8WJl53cpTS7BrhZUVrBaoQQmTDEDsTvfXY27eSHwax9PIwY8yXJnTS.fIHbjLIYGW3n4vfe2o_
 S.wD25aanqKagqMYl6SXJaedseaBS7tSfwatUPxUEZ5lYVxjz0LNqlOFGrpKhtkL6eAeMiohS7Xe
 HgW_3iEEFtLgQMq3VozjugRZCFne46tqQcvtYm8dPcrWu63Fen5Db9QpPB.tR19AVqiFUCgE2MK2
 7Yst8NoMvSBj4_4pAvQd.LJX8VO9G07pLvAJBQC1uhaZrrOe.r434AjtS1UffpO2CZ.4Xt1wW9fZ
 dmiTlfBTE30WnyfU4Llg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 18 Jan 2019 18:49:10 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp418.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8392803232bc6167aeb0315bbbe35bf1;
          Fri, 18 Jan 2019 18:49:07 +0000 (UTC)
Subject: Re: evm_inode_init_security and module stacking
To:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <f1a86814-716a-d02d-42ce-8ef64d680feb@schaufler-ca.com>
 <1547778689.3982.20.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <9e142269-fd2e-b62e-f3fc-687d400aefd1@schaufler-ca.com>
Date:   Fri, 18 Jan 2019 10:49:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547778689.3982.20.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/17/2019 6:31 PM, Mimi Zohar wrote:
> On Thu, 2019-01-17 at 16:47 -0800, Casey Schaufler wrote:
>> security_inode_init_security() currently calls at most one
>> of selinux_inode_init_security() and smack_inode_init_security().
>> It then sends the result to evm_inode_init_security to create
>> the security.evm attribute. This isn't going to work on a system
>> that has both SELinux and Smack.
> Calculating security.evm based on multiple xattrs sounded really
> familiar.  Looking back at the git log, 9d8f13ba3f48 ("security: new
> security_inode_init_security API adds function callback") addressed
> filesystems wanting to be able to write all the xattrs at the same
> time and prepared for multiple LSM xattr support.

Right. That provides for security.selinux, security.SMACK64
and security.evm at the same time. What it doesn't help with
is what goes into security.evm.

>> I see two options:
>> 	- create security.evm with the information from all
>> 	  security modules that provide inode_init_security hooks
>> 	- create a separate attribute for each module,
>> 	  security.evm-selinux and security.evm-smack in the
>> 	  current case.
>>
>> How would you like to have it work? I am agnostic, although the
>> separate attributes would be easier for the infrastructure.
> Having separate attributes for each LSM module would require re-
> calculating the hmac for each one, any time any of the other file
> metadata changed.  That doesn't sound like a good idea.

OK. So it sounds like I need to gather up data from all of the
LSMs (e.g. security.selinux, security.SMACK64) and pass the combination
to evm_inode_init_security(). Will that work? Will that provide the
integrity sub-system what it needs?

> Mimi
