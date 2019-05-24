Return-Path: <SRS0=sk88=TY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AA4C072B5
	for <linux-security-module@archiver.kernel.org>; Fri, 24 May 2019 19:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8DA217F9
	for <linux-security-module@archiver.kernel.org>; Fri, 24 May 2019 19:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="B6SlWXHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfEXT0e (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 24 May 2019 15:26:34 -0400
Received: from sonic305-8.consmr.mail.bf2.yahoo.com ([74.6.133.47]:45029 "EHLO
        sonic305-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729017AbfEXT0e (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 May 2019 15:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1558725992; bh=BckPA1g7a2t/YsHIxiGxkc28qYZ9HyCw2S6mC7Yvo7I=; h=To:Cc:From:Subject:Date:From:Subject; b=B6SlWXHoVgdxjz9urW0DEvRsxqh38NFApPRvrqVZylhn/UmW+w6aMbz+CK3HG/rmXWHpGAxUc158djq31CdJL2xg6p6sARc8xCVuZo9VlA3c2sG96jjY+pjxLFnjPY9F10RTWEUabruX4MnwBijjlg2Qgm2dvoQkOBCieQHmIHJ/GYdqjVisPZBTbvFVLoImrT32bDje1WS2Lg6EQOIJ3VPepa9ca+OXQG41bsAxJ0FK3mDGIj98sAWgYu1JY2lwUtEF2agAVeoq/G1SDvcbFGWSL7PckE7+nIvIupH9b0Q04DN1demyVopgUFwS9Wg3EEEIKLAJIA5gkVsGYushjw==
X-YMail-OSG: ZsJhB4EVM1kdXjqBE95isscD9rFzw6YCO0VoZipRxzTAs2oq3IMCBRKJvwXzgJR
 rKAkKz.wTnLQhcNhWiYP00AxyBwoDwxZpd9fkSW.x0UhC_YaodLiGTscOf0qwCfk9N1JuKpns0mn
 ViIR7wgEzki0nM124DgPtazroWkz05M1DtLoffpF1aNALqdTvwXE_UIv8MIIMtX3vWQcBcY3mVFp
 gHBj0r2rNb2bD.6vBq2p6tGhoxbTvEG5Hf8MECjrY6_oGQRW1AJZn70WoSBZMRyZfhMPPEUai157
 M3blqN9BhIjKm427LIcvkNzWRbey20XVP5djOstR28qbmkIfD68esAhW31kMRdcipealSr1QmmRR
 jryR5m.Hmf6oWQEHe9cmYzCz5qnAzNBF2wUYGfCHlS7YEeuLzFkPzmYD_0SlnAQRxdMpJJz2gZPA
 a1gKdsbVXXCAvkDylj8xDOsOEPd5IUpZ0T8NibndsJci5.IOgkwJaM.xyHBDs9DS3kP9sSKR4wKr
 2j3vZbkasKEZLlEapYrKXJEpYXWwaVLZ97FGmME4eNabTSWGpAschrJCboIlzxT.VActf.zYU4Ux
 61tN0_cYf.ExQaPhfsh_yU6eYx4vjlEe0oyzhYR8PTtVYijsT2euqVEJMYh0ZRZ8_Vg1YMBs7meQ
 .PWqkDliMnqEmkvMHXslpEqyPvmA_obd2_VKBq1F5oLCQlwLoZ1S_hmPMCo0dFfuNzpoacB0w9qw
 pqh5nwFtHLALHeoJVxSUEoNB8TdMAurW0GfBzkBVPtBSGoILG5SYp_XaExxkBPY.wi_7w6Hz.mY9
 _nbJv048OtNY8lOaZ3_LVneRS0MFFCnC8nNFzME5ChItbIwnFKAR0r_GtotHe5m1cvkdZzilT9Ox
 d3.a1usJKMQHPmlrjMKO8tWuV7Zy.M38LWSL_AAGActCXeIc8uUNtRinVMfGMz0Hb4zZCfdClo.7
 gvHuddKhwkBco5QqgLAMNTnKgpCGMaNMXlXmT3jw86ertVrbAPpTuiCeuvuwDK6WwhVY.AfwCtvO
 mJjVZ_10u2u6m_aHUGUQNlcbRKKvoiMzt.sL.67yRoQTFfmRjwjK8nRlq3Hrf7O7O1QafJhS.Zp0
 Tw6l6xwxq6JBZxS9MAZSjWlcvoSL_zoyUmHGwnCfdPYJB9e5pjSGK7ZlA_rc.ig93Tu_KGbcMCwS
 BUgeQdfjqfNIgJDOmJxcwLeVimrROlm5ntcZPFiQGXKppJLFQ4FPn6VXivvCGKvoZb83e9OReYn2
 HfSRmRg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 24 May 2019 19:26:32 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp403.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 262e9d838a6ec46eab94aefe18b59859;
          Fri, 24 May 2019 19:26:31 +0000 (UTC)
To:     Linux Security Module list <linux-security-module@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>, casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Stacking patches for 5.3
Openpgp: preference=signencrypt
Message-ID: <1106985e-1620-75b2-d6bf-c2c95d9a0fbb@schaufler-ca.com>
Date:   Fri, 24 May 2019 12:26:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I have a set of 59 patches for the nest round of LSM stacking.
They are all really small. Kees has expressed a preference for
small patches. I think that the collapsed set of about 10 would
make more sense. Which would the community as a whole prefer?
The patches are not much different from what has been presented
already.

