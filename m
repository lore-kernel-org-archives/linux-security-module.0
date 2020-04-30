Return-Path: <SRS0=qseI=6O=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BEBC4724C
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Apr 2020 13:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394582074A
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Apr 2020 13:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgD3Nmx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:42:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726577AbgD3Nmx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 Apr 2020 09:42:53 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UDabZW014329;
        Thu, 30 Apr 2020 09:42:43 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30q7qjy82w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 09:42:43 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03UDad0e014593;
        Thu, 30 Apr 2020 09:42:42 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30q7qjy81w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 09:42:42 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03UDf7E4017958;
        Thu, 30 Apr 2020 13:42:40 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5tn88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 13:42:40 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03UDgc4A64487508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 13:42:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D476A405C;
        Thu, 30 Apr 2020 13:42:38 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12FE1A405B;
        Thu, 30 Apr 2020 13:42:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.170.249])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Apr 2020 13:42:36 +0000 (GMT)
Message-ID: <1588254156.5167.32.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] ima: add policy support for the new file open
 MAY_OPENEXEC flag
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     kbuild test robot <lkp@intel.com>, linux-integrity@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Mickael Salaun <mic@digikod.net>,
        Steve Grubb <sgrubb@redhat.com>, Jann Horn <jannh@google.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 30 Apr 2020 09:42:36 -0400
In-Reply-To: <202004300526.H4rF1lW2%lkp@intel.com>
References: <1588167523-7866-3-git-send-email-zohar@linux.ibm.com>
         <202004300526.H4rF1lW2%lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_08:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004300111
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Mickaël,

On Thu, 2020-04-30 at 05:24 +0800, kbuild test robot wrote:
> Hi Mimi,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on integrity/next-integrity]
> [also build test ERROR on linus/master v5.7-rc3 next-20200429]
> [cannot apply to security/next-testing]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

To prevent this sort of message, in the future could you include this
patch (2/2) with your patch set?  Please include the "Reviewed-by:
Lakshmi Ramasubramanian <nramas@linux.microsoft.com>" tag.

thanks,

Mimi

> 
> url:    https://github.com/0day-ci/linux/commits/Mimi-Zohar/ima-extending-IMA-policy-to-support-interpreters/20200430-030608
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
> config: arc-allyesconfig (attached as .config)
> compiler: arc-elf-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=arc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    security/integrity/ima/ima_main.c: In function 'ima_file_check':
> >> security/integrity/ima/ima_main.c:442:20: error: 'MAY_OPENEXEC' undeclared (first use in this function); did you mean 'MAY_OPEN'?
>      442 |         MAY_EXEC | MAY_OPENEXEC |
>          |                    ^~~~~~~~~~~~
>          |                    MAY_OPEN

