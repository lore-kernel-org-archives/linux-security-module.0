Return-Path: <SRS0=ekpI=AH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32756C433E0
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Jun 2020 02:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1019E20679
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Jun 2020 02:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgFZCfO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Jun 2020 22:35:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728103AbgFZCfN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Jun 2020 22:35:13 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05Q2WOwb195635;
        Thu, 25 Jun 2020 22:35:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31w3a3ffv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 22:35:03 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05Q2WPOu195853;
        Thu, 25 Jun 2020 22:35:03 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31w3a3ffu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 22:35:03 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05Q2VXjf028512;
        Fri, 26 Jun 2020 02:35:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 31uusjjcxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 02:35:01 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05Q2YxFa11927836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jun 2020 02:34:59 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 587145204E;
        Fri, 26 Jun 2020 02:34:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.142.225])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 30F385204F;
        Fri, 26 Jun 2020 02:34:58 +0000 (GMT)
Message-ID: <1593138897.27152.449.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: AppArmor satisfies the audit rule requirements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 25 Jun 2020 22:34:57 -0400
In-Reply-To: <20200623233823.904882-1-tyhicks@linux.microsoft.com>
References: <20200623233823.904882-1-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_20:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006260012
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2020-06-23 at 18:38 -0500, Tyler Hicks wrote:
> AppArmor meets all the requirements for IMA in terms of audit rules
> since commit e79c26d04043 ("apparmor: Add support for audit rule
> filtering"). Update IMA's Kconfig section for CONFIG_IMA_LSM_RULES to
> reflect this.
> 
> Fixes: e79c26d04043 ("apparmor: Add support for audit rule filtering")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Thanks

Mimi
