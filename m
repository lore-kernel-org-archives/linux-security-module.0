Return-Path: <SRS0=u7jB=NS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6758DC0044C
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Nov 2018 15:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F9120827
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Nov 2018 15:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F9120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeKHAjE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:39:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726830AbeKHAjE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Nov 2018 19:39:04 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA7F00Du006237
        for <linux-security-module@vger.kernel.org>; Wed, 7 Nov 2018 10:08:18 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nm0stvsng-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 07 Nov 2018 10:08:18 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 7 Nov 2018 15:08:16 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 7 Nov 2018 15:08:14 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA7F8DbO60817504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Nov 2018 15:08:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A7A35204E;
        Wed,  7 Nov 2018 15:08:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.87.233])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 44F7E52057;
        Wed,  7 Nov 2018 15:08:12 +0000 (GMT)
Subject: Re: [KEYUTILS PATCH] Add manpages for asymmetric key type and ops
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     David Howells <dhowells@redhat.com>,
        Denis Kenzior <denkenz@gmail.com>
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        mtk.manpages@gmail.com
Date:   Wed, 07 Nov 2018 10:08:01 -0500
In-Reply-To: <13898.1541601730@warthog.procyon.org.uk>
References: <13898.1541601730@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18110715-4275-0000-0000-000002DCBA08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110715-4276-0000-0000-000037E9DBF3
Message-Id: <1541603281.3928.2.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-07_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=748 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811070135
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2018-11-07 at 14:42 +0000, David Howells wrote:
> Add man pages for asymmetric key type and ops
>     
> Add manual pages for the asymmetric key type and its specialised keyctl
> operations.

After cloning the man pages*, I'm having troubles applying this patch.
 Any suggestions?

Mimi

*https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git

