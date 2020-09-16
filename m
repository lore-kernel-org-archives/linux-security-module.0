Return-Path: <SRS0=TMVc=CZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FADC433E2
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 22:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F8C62087D
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 22:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W7uHI0jP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIPWwB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Sep 2020 18:52:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbgIPWwB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Sep 2020 18:52:01 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GMWFka096278;
        Wed, 16 Sep 2020 18:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=mD5J2m9mVxfbwRwuig36H0SZbVnvMzPmhArUub6MZiY=;
 b=W7uHI0jPQgJHeOZg/zw7uyIeUFVMIhMMkERp7XmYUE4gkdrZa4jMRIpcb2bV/cc414QO
 tUhHgAM63GM6hxvusOR85tAqXzuiIuF4LPw38xMey7eLAHIkahFpNKyB2dfSUG974mbr
 4c9hGsl5GiNOktc66BbKbiANMYLY9TNW/c+zHfu1/HI1a+WHbn35QUzwZGLv+sY3mOz9
 6b1pHFbl4VlH56jQtp/7Ox6lq+h2MoBDTnJF/mU9aKWyZOV0NDhbzImPZ/XrIylH6JkG
 zBXQ2Ce2YaUCHLNAdTySdsEbks+DK78KRSiL/u0QIg3nxCWPXZccknykfgu69O9/ZtNs BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33kt9ba7b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 18:51:57 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08GMpuNL019444;
        Wed, 16 Sep 2020 18:51:56 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33kt9ba7aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 18:51:56 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08GMmeu0031548;
        Wed, 16 Sep 2020 22:51:54 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 33k6esh45k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 22:51:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08GMppkZ19464486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 22:51:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEC0942045;
        Wed, 16 Sep 2020 22:51:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 100CD42042;
        Wed, 16 Sep 2020 22:51:50 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.98.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Sep 2020 22:51:49 +0000 (GMT)
Message-ID: <1e1177862e4465cadbb65ee3ad0adfae3f4ec92e.camel@linux.ibm.com>
Subject: Re: [PATCH v3] ima: Fix NULL pointer dereference in ima_file_hash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Florent Revest <revest@chromium.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jann Horn <jannh@google.com>
Date:   Wed, 16 Sep 2020 18:51:49 -0400
In-Reply-To: <20200916180242.430668-1-kpsingh@chromium.org>
References: <20200916180242.430668-1-kpsingh@chromium.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_13:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=866 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160160
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2020-09-16 at 18:02 +0000, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> ima_file_hash can be called when there is no iint->ima_hash available
> even though the inode exists in the integrity cache. It is fairly
> common for a file to not have a hash. (e.g. an mknodat, prior to the
> file being closed).
> 
> Another example where this can happen (suggested by Jann Horn):
> 
> Process A does:
> 
> 	while(1) {
> 		unlink("/tmp/imafoo");
> 		fd = open("/tmp/imafoo", O_RDWR|O_CREAT|O_TRUNC, 0700);
> 		if (fd == -1) {
> 			perror("open");
> 			continue;
> 		}
> 		write(fd, "A", 1);
> 		close(fd);
> 	}
> 
> and Process B does:
> 
> 	while (1) {
> 		int fd = open("/tmp/imafoo", O_RDONLY);
> 		if (fd == -1)
> 			continue;
>     		char *mapping = mmap(NULL, 0x1000, PROT_READ|PROT_EXEC,
> 			 	     MAP_PRIVATE, fd, 0);
> 		if (mapping != MAP_FAILED)
> 			munmap(mapping, 0x1000);
> 		close(fd);
>   	}
> 
> Due to the race to get the iint->mutex between ima_file_hash and
> process_measurement iint->ima_hash could still be NULL.
> 
> Fixes: 6beea7afcc72 ("ima: add the ability to query the cached hash of a given file")
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Florent Revest <revest@chromium.org>

Thanks, the patch is queued in next-integrity-testing.

Mimi

