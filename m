Return-Path: <SRS0=0itc=OV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D112EC65BAF
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 17:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939A520851
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 17:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CFcfhHGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939A520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeLLRwl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:52:41 -0500
Received: from sonic312-27.consmr.mail.bf2.yahoo.com ([74.6.128.89]:34168 "EHLO
        sonic312-27.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726922AbeLLRwl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Dec 2018 12:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544637160; bh=dBIr5fnLKopjQLQ4SH4DE2hidJU3j3qCb8d6LfF1QHA=; h=Subject:From:To:References:Date:In-Reply-To:From:Subject; b=CFcfhHGNqh0FPIxfyT9xXX/MqGy5fWUIxkbGRCYHNYw6GArU5UNEYU45gRTLavdVO5AP4o3osmNoUUALl/DvR8mZ2bwJBwrJahMTZiOqqJlRsVOJp+rid0ddlWhoMkDiDxIjcZ73r04GVg+t2qcqPSCcgo+yaXDaZe5mKKplRXAts3n80VIyNMiaNnsqg+U1lFhfLHwDsZVYQdBoWOp74yCboWTH/ZY+uVaZevUEtxBmMEdGD7HlQjSuQVaPpqG0/RBboXAUz4/UATkJPS0wE+h3HgRqS3NVeG4CDfWF5h40QsaXbmQ9JdTpypmt/RqDFPjgQ3YSO8XS3OcvfTPpuw==
X-YMail-OSG: _N04BVkVM1kH4FVUMYnSf26dPoInwOHnH58icZ1ZQ0uoKd0tuJsTGLkTR7zL6Om
 7wwgNss3C1nQZtjdJYZYdoGwdbvfMAEGF4C2sNU5GShX4H3LAk55DRcfLwI9pBmNjMnEUhp9DkQI
 HOpdidkNUrKx5oITId3aqgwAZuP2_KMY7Yh.SOjdgcxISnzohNX5Y.71vDrvs4WPlyM3pA5gmb5_
 8lGXFxzNvd.954jG419PsMnlDtTkG1QvdO.n78uvYkj2UK6IhkfkKfSItYpfCI.JfovX0dNjevlo
 _l20OrGN9uhO6kb7ZkthRM1.22czwUCZA7gnL5kB8.R4bB5PSHS4UIUbY.85aDr5bpywy7jhKCe0
 kQVPnYWxyC0Eypt08km1F2TY3Hv85HMJJQNubs8fWvb5mIdOW406woMIGgoAWEDJUz8n119lnmG7
 NnsT2QwXlap1zE9PLGJJimlfbmsAJlhkP4MWhBdPVsDGx_4QpMsmSa_O8QEZBJkvdDHwb95wZFfY
 WqRSzwVLeFnnZQqiu.6bTLKH0.9pXaMC8UeDxBFpeItOtjyvDgKvHHxqFF_GwuMXCEl1UQe0HQ1Q
 O0YHsUjZ2GBt2EpYkq_YmurAo3bKftL35MfCgpNAVeGYnWHNTU2pFYo6Tgb.CeLatexP7uClJcxN
 P2eH7EoxYgDVrImAoeW8znAw9ZRULqMw8UnFCcJT1hJfW7NZ9hifnOoxnxl2O9MxP6y9xMP28EzF
 xk_tGxMYB2ck_4TQQaRVFvjN1qd73Lqng4J2cdhLc5GaNI2gYo3sLvzpTMZ9pYDOGSI_mBalsb7B
 6YSezuX8F.p3EB3USfuny1lpZKL60s_2uWynTMSuYetLZCnfrtUoqXJN44uzsqCB4tfwT9qJFUgu
 1vWsJH6qiuEYRhc5VKzt2MjR5PGY0B2UYWXs2_RbreWYEgLRIp7UteCuhbLqPjT51Vv6oXxwmHmn
 .m31YVnSFnD.S1USwcq2uJl1TKFKL.B2Tuh8Y6.8sJLm_ujHWb8KAXbGd72eHpJZ0tul9Lkc.iLJ
 CJ4YFtldTOVAO1v3FKVcNkD9k3TI3WT3VJ8gXmwKkV2_ELkb5UZqjftRBdvnF42oDgiEp2IyWKJK
 .e6s9drWc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Wed, 12 Dec 2018 17:52:40 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp420.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6eb062703a2f8b39540cd1617afb0b06;
          Wed, 12 Dec 2018 17:52:37 +0000 (UTC)
Subject: Re: [PATCH] Smack: Improve documentation
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     =?UTF-8?Q?Jos=c3=a9_Bollo?= <jobol@nonadev.net>,
        linux-security-module@vger.kernel.org
References: <20181212182657.45205ad1@d-jobol.iot.bzh>
 <69df7223-b0c8-e0fa-bfea-ffc0417fed18@schaufler-ca.com>
Message-ID: <c3abf863-a8cb-21e5-3210-1127cbadb4e4@schaufler-ca.com>
Date:   Wed, 12 Dec 2018 09:52:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <69df7223-b0c8-e0fa-bfea-ffc0417fed18@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 12/12/2018 9:34 AM, Casey Schaufler wrote:
> On 12/12/2018 9:26 AM, José Bollo wrote:
>> Add some words about the mount option "smackfstransmute=label".
>>
>> Signed-off-by: José Bollo <jobol@nonadev.net>
> Thank you. I'll take this.

This posting is in a format that won't apply.

>
>> ---
>>  Documentation/admin-guide/LSM/Smack.rst | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/LSM/Smack.rst
>> b/Documentation/admin-guide/LSM/Smack.rst index
>> 6a5826a13aea..2d5e3e79d190 100644 ---
>> a/Documentation/admin-guide/LSM/Smack.rst +++
>> b/Documentation/admin-guide/LSM/Smack.rst @@ -818,6 +818,10 @@ Smack
>> supports some mount options: specifies a label to which all labels set
>> on the filesystem must have read access. Not yet enforced.
>>  
>> +  smackfstransmute=label:
>> +        behaves exactly like smackfsroot except that it also
>> +        set the transmuting flag on the root of the mount
>> +
>>  These mount options apply to all file system types.
>>  
>>  Smack auditing
>

