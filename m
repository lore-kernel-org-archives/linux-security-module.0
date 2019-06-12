Return-Path: <SRS0=c21G=UL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD66AC31E47
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Jun 2019 13:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E1A20866
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Jun 2019 13:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfFLN2b (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:28:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727693AbfFLN2b (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Jun 2019 09:28:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CDKH8X184587
        for <linux-security-module@vger.kernel.org>; Wed, 12 Jun 2019 09:28:30 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t31fd2r84-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 12 Jun 2019 09:28:29 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 12 Jun 2019 14:28:28 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Jun 2019 14:28:26 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5CDSPuJ52035826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 13:28:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 072C752052;
        Wed, 12 Jun 2019 13:28:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.109.218])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 140F45204E;
        Wed, 12 Jun 2019 13:28:23 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] LSM: switch to blocking policy update notifiers
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>, sds@tycho.nsa.gov,
        paul@paul-moore.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 12 Jun 2019 09:28:13 -0400
In-Reply-To: <20190612074456.2504-1-janne.karhunen@gmail.com>
References: <20190612074456.2504-1-janne.karhunen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061213-4275-0000-0000-00000341AD83
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061213-4276-0000-0000-00003851C3F2
Message-Id: <1560346093.4578.18.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906120092
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Paul,

On Wed, 2019-06-12 at 10:44 +0300, Janne Karhunen wrote:
> Atomic policy updaters are not very useful as they cannot
> usually perform the policy updates on their own. Since it
> seems that there is no strict need for the atomicity,
> switch to the blocking variant. While doing so, rename
> the functions accordingly.
> 
> Changelog v2
> - Rebase to 'next-queued-testing'
> 
> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> Acked-by: Paul Moore <paul@paul-moore.com>

The patches need to be upstreamed together.  Do you have any problems
with my upstreaming them via linux-integrity?

Mimi

