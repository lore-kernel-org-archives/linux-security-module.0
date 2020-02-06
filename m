Return-Path: <SRS0=1co8=32=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8913DC33CAC
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Feb 2020 16:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A5D21775
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Feb 2020 16:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgBFQeG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:34:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727579AbgBFQeF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Feb 2020 11:34:05 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016GXKIq015484
        for <linux-security-module@vger.kernel.org>; Thu, 6 Feb 2020 11:34:04 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0p3jru6h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 06 Feb 2020 11:34:04 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 6 Feb 2020 16:34:02 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Feb 2020 16:33:57 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 016GXudl22216952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Feb 2020 16:33:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FD234C040;
        Thu,  6 Feb 2020 16:33:56 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8882D4C046;
        Thu,  6 Feb 2020 16:33:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.140.59])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Feb 2020 16:33:55 +0000 (GMT)
Subject: Re: [PATCH v2 5/8] ima: Switch to dynamically allocated buffer for
 template digests
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Thu, 06 Feb 2020 11:33:54 -0500
In-Reply-To: <0b91e6977bac4cd5a638041adb3e76eb@huawei.com>
References: <20200205103317.29356-1-roberto.sassu@huawei.com>
         <20200205103317.29356-6-roberto.sassu@huawei.com>
         <1581005284.5585.422.camel@linux.ibm.com>
         <0b91e6977bac4cd5a638041adb3e76eb@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020616-0016-0000-0000-000002E4534F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020616-0017-0000-0000-000033473A06
Message-Id: <1581006834.5585.430.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_01:2020-02-06,2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060125
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 2020-02-06 at 16:27 +0000, Roberto Sassu wrote:
> > -----Original Message-----
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Thursday, February 6, 2020 5:08 PM
> > To: Roberto Sassu <roberto.sassu@huawei.com>;
> > James.Bottomley@HansenPartnership.com;
> > jarkko.sakkinen@linux.intel.com
> > Cc: linux-integrity@vger.kernel.org; linux-security-module@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Silviu Vlasceanu
> > <Silviu.Vlasceanu@huawei.com>
> > Subject: Re: [PATCH v2 5/8] ima: Switch to dynamically allocated buffer for
> > template digests
> > 
> > Hi Roberto,
> > 
> > On Wed, 2020-02-05 at 11:33 +0100, Roberto Sassu wrote:
> > > This patch dynamically allocates the array of tpm_digest structures in
> > > ima_alloc_init_template() and ima_restore_template_data(). The size of
> > the
> > > array, stored in ima_num_template_digests, is initially equal to 1 (SHA1)
> > > and will be determined in the upcoming patches depending on the
> > allocated
> > > PCR banks and the chosen default IMA algorithm.
> > >
> > > Calculating the SHA1 digest is mandatory, as SHA1 still remains the default
> > > hash algorithm for the measurement list. When IMA will support the
> > Crypto
> > > Agile format, remaining digests will be also provided.
> > >
> > > The position in the array of the SHA1 digest is stored in the ima_sha1_idx
> > > global variable and it is determined at IMA initialization time.
> > >
> > > Changelog
> > >
> > > v1:
> > > - move ima_sha1_idx to ima_crypto.c
> > > - introduce ima_num_template_digests (suggested by Mimi)
> > 
> > Instead of hardcoding "nr_allocated_banks + 1" or nr_allocated_banks +
> > 2", I suggested defining "nr_allocated_banks + extra", where "extra"
> > could be 0, 1, or 2.
> > 
> > The rest of the code would remain exactly the same as you had.
> 
> Ok. I did a small improvement. Since we determine the number of
> required elements of ima_algo_array before kmalloc() I thought it
> was ok to directly set that number of elements in a single variable.
> 
> If you think that having two variables is better, I will change it.

The connection to nr_allocated_banks is then not as visible.  Using
two variables is clearer.

Mimi

