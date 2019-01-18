Return-Path: <SRS0=wNUX=P2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECC4C43612
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 02:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680D420883
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 02:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfARCbs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:31:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725992AbfARCbs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Jan 2019 21:31:48 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0I2TJ3c111617
        for <linux-security-module@vger.kernel.org>; Thu, 17 Jan 2019 21:31:47 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q361j847s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 17 Jan 2019 21:31:46 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 18 Jan 2019 02:31:45 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Jan 2019 02:31:42 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0I2Vfja5177704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 02:31:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69F7EA4057;
        Fri, 18 Jan 2019 02:31:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B1E1A4069;
        Fri, 18 Jan 2019 02:31:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.65])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jan 2019 02:31:40 +0000 (GMT)
Subject: Re: evm_inode_init_security and module stacking
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Cc:     LSM <linux-security-module@vger.kernel.org>
Date:   Thu, 17 Jan 2019 21:31:29 -0500
In-Reply-To: <f1a86814-716a-d02d-42ce-8ef64d680feb@schaufler-ca.com>
References: <f1a86814-716a-d02d-42ce-8ef64d680feb@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011802-0028-0000-0000-0000033AB637
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011802-0029-0000-0000-000023F7E367
Message-Id: <1547778689.3982.20.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-18_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=782 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901180018
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 2019-01-17 at 16:47 -0800, Casey Schaufler wrote:
> security_inode_init_security() currently calls at most one
> of selinux_inode_init_security() and smack_inode_init_security().
> It then sends the result to evm_inode_init_security to create
> the security.evm attribute. This isn't going to work on a system
> that has both SELinux and Smack.

Calculating security.evm based on multiple xattrs sounded really
familiar.  Looking back at the git log, 9d8f13ba3f48 ("security: new
security_inode_init_security API adds function callback") addressed
filesystems wanting to be able to write all the xattrs at the same
time and prepared for multiple LSM xattr support.

> I see two options:
> 	- create security.evm with the information from all
> 	  security modules that provide inode_init_security hooks
> 	- create a separate attribute for each module,
> 	  security.evm-selinux and security.evm-smack in the
> 	  current case.
> 
> How would you like to have it work? I am agnostic, although the
> separate attributes would be easier for the infrastructure.

Having separate attributes for each LSM module would require re-
calculating the hmac for each one, any time any of the other file
metadata changed.  That doesn't sound like a good idea.

Mimi



