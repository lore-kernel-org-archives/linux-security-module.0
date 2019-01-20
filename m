Return-Path: <SRS0=UvE5=P4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD66FA3737
	for <linux-security-module@archiver.kernel.org>; Sun, 20 Jan 2019 16:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3591320880
	for <linux-security-module@archiver.kernel.org>; Sun, 20 Jan 2019 16:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfATQma (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 20 Jan 2019 11:42:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726325AbfATQma (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 20 Jan 2019 11:42:30 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0KGdLFx068045
        for <linux-security-module@vger.kernel.org>; Sun, 20 Jan 2019 11:42:29 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q4hq187br-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Sun, 20 Jan 2019 11:42:28 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 20 Jan 2019 16:42:26 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 20 Jan 2019 16:42:24 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0KGgNL77405872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 20 Jan 2019 16:42:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAAE1AE053;
        Sun, 20 Jan 2019 16:42:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8317AE051;
        Sun, 20 Jan 2019 16:42:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.65])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 20 Jan 2019 16:42:22 +0000 (GMT)
Subject: Re: evm_inode_init_security and module stacking
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Cc:     LSM <linux-security-module@vger.kernel.org>
Date:   Sun, 20 Jan 2019 11:42:11 -0500
In-Reply-To: <9e142269-fd2e-b62e-f3fc-687d400aefd1@schaufler-ca.com>
References: <f1a86814-716a-d02d-42ce-8ef64d680feb@schaufler-ca.com>
         <1547778689.3982.20.camel@linux.ibm.com>
         <9e142269-fd2e-b62e-f3fc-687d400aefd1@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19012016-0020-0000-0000-00000308F8BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012016-0021-0000-0000-0000215A2464
Message-Id: <1548002531.3982.202.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-20_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=682 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901200135
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 2019-01-18 at 10:49 -0800, Casey Schaufler wrote:
> On 1/17/2019 6:31 PM, Mimi Zohar wrote:
> > On Thu, 2019-01-17 at 16:47 -0800, Casey Schaufler wrote:
> >> security_inode_init_security() currently calls at most one
> >> of selinux_inode_init_security() and smack_inode_init_security().
> >> It then sends the result to evm_inode_init_security to create
> >> the security.evm attribute. This isn't going to work on a system
> >> that has both SELinux and Smack.
> > Calculating security.evm based on multiple xattrs sounded really
> > familiar.  Looking back at the git log, 9d8f13ba3f48 ("security: new
> > security_inode_init_security API adds function callback") addressed
> > filesystems wanting to be able to write all the xattrs at the same
> > time and prepared for multiple LSM xattr support.
> 
> Right. That provides for security.selinux, security.SMACK64
> and security.evm at the same time. What it doesn't help with
> is what goes into security.evm.
> 
> >> I see two options:
> >> 	- create security.evm with the information from all
> >> 	  security modules that provide inode_init_security hooks
> >> 	- create a separate attribute for each module,
> >> 	  security.evm-selinux and security.evm-smack in the
> >> 	  current case.
> >>
> >> How would you like to have it work? I am agnostic, although the
> >> separate attributes would be easier for the infrastructure.
> > Having separate attributes for each LSM module would require re-
> > calculating the hmac for each one, any time any of the other file
> > metadata changed.  That doesn't sound like a good idea.
> 
> OK. So it sounds like I need to gather up data from all of the
> LSMs (e.g. security.selinux, security.SMACK64) and pass the combination
> to evm_inode_init_security(). Will that work? Will that provide the
> integrity sub-system what it needs?

Casey, as far as I'm aware only real root, currently, is allowed to
write the security xattr domain.  If we assume real root is labeling
the filesystem with both LSM xattrs, there shouldn't be a problem.
 I'm not sure how this is going to work from a namespacing/container
perspective, which I assume is the impetus for LSM module stacking.

I haven't been following Smack.  Have you added Smack xattr support or
thought about it in the context of "containers"?  Are you planning on
appending the info to the existing security.SMACK64 label or having
separate xattrs for each "container"?

Mimi

