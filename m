Return-Path: <SRS0=szIC=CC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35225C433E1
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 20:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092F2204EA
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 20:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LTZe1eH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgHXUeS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:34:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725998AbgHXUeS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Aug 2020 16:34:18 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07OKVq7S048655;
        Mon, 24 Aug 2020 16:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=5UxruWg1y/uPgPkV8OLCmhUuZVY+wffupe7K2rEHVew=;
 b=LTZe1eH1lcf7efRdX3Z3lgEoygOE/U1Ygh3J0c2Y76ydzJOT//VUgio99Lr7z4FTam+J
 rrhnBOla60yqTWR2iVfSeVeyEO5OKbRGQKYfn3Bhbyi79cdKBWBZggq2IC9nD5Yck2PO
 cteNmP2/zmh0xWdYRfhEVzNmf/t3tNwBKA4cw9iaL/lygIvPjcGaBLVjWhHin16YV3le
 Wul+MVw8upWXJYHqlEMm/pULbk0hyYXv8NIIbvpotARMe7U7jTe8TkVwWXs5W4wel5e1
 xnjb/62ymfAfbnzT+gmMj+RbWpBvmiulCXzr6V7gCyVkLja6QnOjVBof9oxVuANzgtfQ zw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 334kvgsm7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 16:34:06 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07OKRBYJ008371;
        Mon, 24 Aug 2020 20:34:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 33498u8mmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 20:34:04 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07OKY2Gj23527812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 20:34:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 201415205A;
        Mon, 24 Aug 2020 20:34:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.38.197])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6E25C5204F;
        Mon, 24 Aug 2020 20:34:00 +0000 (GMT)
Message-ID: <7a347b605b68aabfbc160b62fc4394fb52d9de4e.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: Use current_uid() in
 integrity_audit_message()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Aug 2020 16:33:59 -0400
In-Reply-To: <20200824125435.487194-1-efremov@linux.com>
References: <20200824125435.487194-1-efremov@linux.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 mlxlogscore=891 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240157
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2020-08-24 at 15:54 +0300, Denis Efremov wrote:
> Modify integrity_audit_message() to use current_uid().
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Thank you.  This patch is now queued in next-integrity-testing.

Mimi


