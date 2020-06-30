Return-Path: <SRS0=UBGi=AL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA1FC433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Jun 2020 12:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC6420702
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Jun 2020 12:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgF3MC4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:02:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729647AbgF3MC4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Jun 2020 08:02:56 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05UBZI7U013606;
        Tue, 30 Jun 2020 08:02:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ycja0bqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 08:02:21 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05UC2A7p076098;
        Tue, 30 Jun 2020 08:02:10 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ycja0akv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 08:02:10 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05UBkeGw017788;
        Tue, 30 Jun 2020 11:58:32 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 31wwcgspgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 11:58:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05UBwU8d4522250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 11:58:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E7E6A405C;
        Tue, 30 Jun 2020 11:58:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BF95A4060;
        Tue, 30 Jun 2020 11:58:28 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.137])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 30 Jun 2020 11:58:28 +0000 (GMT)
Date:   Tue, 30 Jun 2020 14:58:26 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     hackapple <2538082724huangjinhai@gmail.com>
Cc:     James.Bottomley@hansenpartnership.com,
        alexandre.chartre@oracle.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jwadams@google.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        pjt@google.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [RFC PATCH 1/7] x86/cpufeatures: add X86_FEATURE_SCI
Message-ID: <20200630115826.GB1951986@linux.ibm.com>
References: <94E40D06-B481-45B7-A929-CC324F5B856B@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94E40D06-B481-45B7-A929-CC324F5B856B@qq.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_04:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=766 lowpriorityscore=0 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=1 adultscore=0
 cotscore=-2147483648 bulkscore=0 clxscore=1011 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300086
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 30, 2020 at 08:08:59AM +0800, hackapple wrote:
> What’s the version of kernel?

It was around 5.2 time frame, I think.

-- 
Sincerely yours,
Mike.
