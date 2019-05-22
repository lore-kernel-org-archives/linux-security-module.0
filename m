Return-Path: <SRS0=vdt1=TW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2DEC46470
	for <linux-security-module@archiver.kernel.org>; Wed, 22 May 2019 13:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3890A20868
	for <linux-security-module@archiver.kernel.org>; Wed, 22 May 2019 13:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfEVNAk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 May 2019 09:00:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728638AbfEVNAk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 May 2019 09:00:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MCwKws020750
        for <linux-security-module@vger.kernel.org>; Wed, 22 May 2019 09:00:40 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sn5qfu9xn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 22 May 2019 09:00:39 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 22 May 2019 14:00:37 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 May 2019 14:00:34 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4MD0XD061669532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 13:00:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A131C11C066;
        Wed, 22 May 2019 13:00:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D85F411C052;
        Wed, 22 May 2019 13:00:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.204])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 May 2019 13:00:32 +0000 (GMT)
Subject: Re: sleep in selinux_audit_rule_init
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Janne Karhunen <janne.karhunen@gmail.com>, paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 22 May 2019 09:00:22 -0400
In-Reply-To: <4a725f06-8244-8264-a911-df7ca1c66789@tycho.nsa.gov>
References: <CAE=NcrYsfQ2ijJJMEyTFoWnFqF2qGS=B2JNsVaE8WUNcGS7D9Q@mail.gmail.com>
         <e8dcc9a2-594d-f81a-32a7-e18f591c6062@tycho.nsa.gov>
         <4a725f06-8244-8264-a911-df7ca1c66789@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052213-0008-0000-0000-000002E9487C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052213-0009-0000-0000-0000225602FC
Message-Id: <1558530022.4347.11.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220095
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2019-05-22 at 08:41 -0400, Stephen Smalley wrote:
> Another potentially worrisome aspect of the current 
> ima_lsm_update_rules() logic is that it does a BUG_ON() if the attempt 
> to update the rule fails, which could occur if e.g. one had an IMA 
> policy rule based on a given domain/type and that domain/type were 
> removed from policy (e.g. via policy module removal).  Contrast with the 
> handling in audit_dupe_lsm_field().  The existing ima_lsm_update_rules() 
> logic could also yield a BUG_ON upon transient memory allocation failure.

The original design was based on the assumption that SELinux labels
could not be removed, only new ones could be added.  Sounds like that
isn't the case any longer.

Mimi

