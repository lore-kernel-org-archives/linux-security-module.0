Return-Path: <SRS0=TMVc=CZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D74C43461
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 20:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032BA20731
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 20:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZC3DBNec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgIPU5C (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:57:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726328AbgIPQwh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Sep 2020 12:52:37 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GFmeJI113957;
        Wed, 16 Sep 2020 12:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=oR2/YwL1liHbE41SOzBmZTcOtgNASTFaWbA+0ZtZrX8=;
 b=ZC3DBNecdsCrKlYL0jMJVJI+qkE9QrjhaE9TkmnM+IAPH1OuyFde0M8I4sKTVT8KASK7
 cSynfxx8wogcj1UBc2xpQVGJB/tEqdV5SYr37Ct9j7f5vYwVVq5OM9UaDBd1vFP9Vde9
 cGGEckclxtrx+qbHHfYhkl6a47ONLsTzhtLg7SWhJ/y0Ky7Dpx/FsclcvXoh1tW2dIij
 i1BZm6hBylaNTc8MeHqemhC1ctGBGq2sLI8a/W2FRJK/7BRcsyS161CssbI4UXLiWW4I
 pFhTRXSNEPKJSvGyz43Xglv9zud72DosstaPj3NcbAe3HZt/kVxCQLNxB9BXx2MSisvR TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33knp3ga9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 12:00:18 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08GFnZb4120125;
        Wed, 16 Sep 2020 12:00:18 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33knp3ga7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 12:00:18 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08GFwsMY012798;
        Wed, 16 Sep 2020 16:00:16 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 33k6esgt3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 16:00:15 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08GG0DYF9372018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 16:00:13 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EA56A4066;
        Wed, 16 Sep 2020 16:00:13 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93DA4A4062;
        Wed, 16 Sep 2020 16:00:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.98.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Sep 2020 16:00:11 +0000 (GMT)
Message-ID: <8cee070eed5b8a3dc9f373fc9db8d99a70b7d75a.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: Fix NULL pointer dereference in ima_file_hash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Florent Revest <revest@chromium.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jann Horn <jannh@google.com>
Date:   Wed, 16 Sep 2020 12:00:10 -0400
In-Reply-To: <20200916124931.1254990-1-kpsingh@chromium.org>
References: <20200916124931.1254990-1-kpsingh@chromium.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_10:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160113
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2020-09-16 at 14:49 +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> ima_file_hash can be called when there is no iint->ima_hash available
> even though the inode exists in the integrity cache.
> 
> An example where this can happen (suggested by Jann Horn):
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
> ---
>  security/integrity/ima/ima_main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 8a91711ca79b..4c86cd4eece0 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -531,6 +531,16 @@ int ima_file_hash(struct file *file, char *buf, size_t buf_size)
>  		return -EOPNOTSUPP;
>  
>  	mutex_lock(&iint->mutex);
> +
> +	/*
> +	 * ima_file_hash can be called when ima_collect_measurement has still
> +	 * not been called, we might not always have a hash.
> +	 */
> +	if (!iint->ima_hash) {
> +		mutex_unlock(&iint->mutex);
> +		return -EOPNOTSUPP;
> +	}
> +

Not having a file hash is rather common (e.g. mknodat, prior to the
file being closed).  Before appraising the integrity of a file, it
checks whether it is a new file (eg. IMA_NEW_FILE), but, unfortunately,
the flag is only set for those files in the appraise policy.

The patch looks fine, but you might want to reflect not having a file
hash is common in the patch description.

Mimi

>  	if (buf) {
>  		size_t copied_size;
>  


