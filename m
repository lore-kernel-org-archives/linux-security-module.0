Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37806C001DF
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Aug 2023 22:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjHBW7M (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Aug 2023 18:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjHBW7I (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Aug 2023 18:59:08 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57101718;
        Wed,  2 Aug 2023 15:59:01 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372MrWD4026357;
        Wed, 2 Aug 2023 22:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=x1bhK8dC22U7nBkktIiSBiPfWiw/5rtVn0oMZZMLaj0=;
 b=UyGIrNJav1YNExxLEZAg5yqY4gPKsl3Cw0MlbfmBRTD8QcVxbHw67j0xcTimVXsDl0Yc
 zBRswQA9JJGANPMhNz8D42DhW6N7oATayKnxfJwXC6rhjdti70VWslK3hFRl0P0vfO0L
 AHWwTB0RsBXtCiGTxMZ0JmiNqzRyUAkaFa2EsQ6kHCtzSz4cdrjBKpSYJ2C7Hd/1+wRN
 dSH9PnA5zPGRdCDRxkr3C9sXnRqHDT2wANCnPJTAS3ijWF4/Cl8XfXbZJGV18U6rUR8I
 ATR22fKetJj4o49zPwhVakO3NOk2ttNHAeu/ugpwD2T730eZt7Yema6goEgYE4goQYSc Hw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s80ba8274-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 22:58:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 372LtUKN017127;
        Wed, 2 Aug 2023 22:58:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s5fak0222-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 22:58:52 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 372Mwqnu6554344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Aug 2023 22:58:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F27B58056;
        Wed,  2 Aug 2023 22:58:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04CED5803F;
        Wed,  2 Aug 2023 22:58:52 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.115.23])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Aug 2023 22:58:51 +0000 (GMT)
Message-ID: <ae9174eff39d4bd57c603d0dca78dd04c7dccbb8.camel@linux.ibm.com>
Subject: Re: [PATCH 3/6] integrity: remove global variable from
 machine_keyring.c
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Aug 2023 18:58:51 -0400
In-Reply-To: <20230714153435.28155-4-nayna@linux.ibm.com>
References: <20230714153435.28155-1-nayna@linux.ibm.com>
         <20230714153435.28155-4-nayna@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K7SAyDXmebBoxI_mE__j_PeNqQ_370Yh
X-Proofpoint-ORIG-GUID: K7SAyDXmebBoxI_mE__j_PeNqQ_370Yh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=908 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020199
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 2023-07-14 at 11:34 -0400, Nayna Jain wrote:
> trust_mok variable is accessed within a single function locally.
> 
> Change trust_mok from global to local static variable.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>

