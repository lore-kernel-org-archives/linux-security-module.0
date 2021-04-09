Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AF4C433B4
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Apr 2021 18:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6427D6115B
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Apr 2021 18:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhDISu3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:50:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234313AbhDISu1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Apr 2021 14:50:27 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 139IXaWs080310;
        Fri, 9 Apr 2021 14:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bXvWzn00WBimAoSqYZ8BuvquyHQosk2Hc5yyYjVSe7s=;
 b=BlIn2jwwTeFtOJekXGVP9/L07qYZHBdujPLf2R7wBXT14HFd/pk05WpcPo1RK5yeP3bq
 BVHCt4SLZi+WIfEwC14sYnwAxQPa8ZUaGggF9HQDzUNv6cEJJMzkSR+rgtklmdOFgxt3
 k94DXHmIQnUf9LOp+BlGj+D1Hczjr07OS+DnIYBZFWuGqSlPqnsY4v3cDH94455g34vj
 KzQWWbOPHeE5LDHblb6/QFvleJV0R9fO91udFQlcKqJH9URKN5Yq0IUdf7QxBzar8DgA
 UNaJjRT1DGV9S3XcAQJz9NJXRLLw224cvifAbvGZfqJjV460p9M971v7g0SiGQrdgLgh Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37tunh1bjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 14:50:12 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 139IXbHE080392;
        Fri, 9 Apr 2021 14:50:11 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37tunh1bhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 14:50:11 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 139ImutW017941;
        Fri, 9 Apr 2021 18:50:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 37rvbwap53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 18:50:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 139Inj6433751368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Apr 2021 18:49:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D51934204B;
        Fri,  9 Apr 2021 18:50:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 910C04204F;
        Fri,  9 Apr 2021 18:50:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.54.65])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Apr 2021 18:50:05 +0000 (GMT)
Message-ID: <e5255a234d022726d892766969d37cd894ea8e03.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: Fix function name error in comment.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jiele Zhao <unclexiaole@gmail.com>, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 09 Apr 2021 14:50:04 -0400
In-Reply-To: <20210406021210.2843-1-unclexiaole@gmail.com>
References: <20210406021210.2843-1-unclexiaole@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: COzyK8LmymYZU4ryIN8fw9WCpgu5Pjmj
X-Proofpoint-GUID: Ryspu2l-7B2iyc7wEFOwWTma3nx-8IJU
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_07:2021-04-09,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090133
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2021-04-06 at 02:12 +0000, Jiele Zhao wrote:
> The original function name was ima_path_check().  The policy parsing
> still supports PATH_CHECK.   Commit 9bbb6cad0173 ("ima: rename
> ima_path_check to ima_file_check") renamed the function to
> ima_file_check(), but missed modifying the function name in the
> comment.
> 
> Fixes: 9bbb6cad0173 ("ima: rename ima_path_check to ima_file_check").
> 
> Signed-off-by: Jiele Zhao <unclexiaole@gmail.com>

Thanks, Jiele.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git 
next-integrity

Mimi

