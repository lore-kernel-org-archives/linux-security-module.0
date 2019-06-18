Return-Path: <SRS0=MF6I=UR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58411C31E61
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Jun 2019 20:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FC321479
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Jun 2019 20:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cC+4bKQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbfFRUyj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:54:39 -0400
Received: from sonic311-30.consmr.mail.gq1.yahoo.com ([98.137.65.211]:34146
        "EHLO sonic311-30.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730788AbfFRUyi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Jun 2019 16:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560891277; bh=uiFIgSD2hHLXe67e7C7F+Zs4WDsQyHmzpiW3zc3E5z4=; h=To:Cc:From:Subject:Date:From:Subject; b=cC+4bKQU4/nY5S/4KsdcrcTSptayS6pdh5gQFPV1iDIS8fS0FvUP1IvEO1mKjYiolJKOQCRHTFjRjN1xjvS0zBzVdUmmNQSl/+l3JBIXdiZ9L5tdUuAZIwKLPD9Brt9Qykc+X2MBlZkXA9VHBkDz8Y9BjZw1kfX/LGG/RMScir/f/9hNpQjzFq5FL+t07yj8xiE1dJe3hbPUCjwf5EdY8deT1xW8DzU7Hr0vkgrsVpP2RiBO0yj6mW6PZ0oD8iZZcjXSmIBImRKhjpj5V1+rDxlQoi20itWtlZEYjhp7gkhLKORl2IrgAeosMuY3L4Pr+IcUEkCa3IKJAFVtAr0PSw==
X-YMail-OSG: R4NngvwVM1mB_OmjU6CIfRUAZM8oe1RHCKSamnOe8Z43fs9_vb.rEDw4ybl3XN2
 AFzb07g79aJB3Dv0dYjnpKmk6BQVOXoEaTLe8AMQXZmZZTu1OIavVUeoCAZIu0V7Lg_g8k9GCVwr
 HG9g8l8WBJc9OYZQDI1CkDrJwDgCWQtyfQdd7L._jO5Q9Rwu_Dh.BEn3bew2b_HrAZEQCdIwc5Qd
 Gzp27vGN5BD.2WyZ0OOUj2TTj44MF.9mGXXpz.g6F1.7oDmGAc6SP5m1dHgSigXFFW4PBimVVDf_
 bDj0AANUB9_r.hAsTaxLrfBajWpX_uYMvrcC55DiXfuXShWlqAu1mUSSBjkbRYomAelMy0kbTuKV
 IA8C1suQhIAy8ixqHCGlRYABOluJuR4K7vG3MWxRicL4jx16CfSjeJygvEl15ZPE5DWdg.9DVHq6
 9E6IZ7kCThBlGh6Iwk1mzYLzhec6DNmBPZ4AVXOychees1PFws66Mj.VPWIpAs9mGc7UCSsk_ush
 VNzEaMZFd2TmC6BddnugJhFACFgQwustnvhGDftVLhf7G7k8uNfOAi2WswMUbJ._uB5trreEcaiA
 oIreJqYseJE1sJCS.HaXXBzj7muWkIfIZYuBlrLhGFAqQcf8pRvM7i42VL0kT60hzb0MFxVIyz6P
 pDGsJHRI37n8CCu6fb.fG9VeTjfDYz4FI3LwOmx2_ehiNIJQ3NnW9xg9epl4Uv5mU9_6RhxJceFv
 SNO3CyF4DHfw3.11W64fM_jdUCyxn0lgby61wW2Ubt0EyO0apWY0wBzkhvKAtYGZSr38kb2beC_4
 D6irkJVhEWaY8hVeeG5KMPIwn3yYKmxGgP8FM.8vhE0McRJboK_Nq9Djt_AV4JrcMr5ZADRYqG05
 jm9S5kLs6ep1LgWJYkTZb4zAX6SXDbv7B.3ya_onZfc3G2roQfgqS4c1GksXN2TK1Pfqeb2izA.o
 CgwZ24nEB5tjNU16gmo_Z7kDxijA_z9ep0_PXjP8NoddUWBzCqXsg8gsh99fQHoemAfM3aFQf0z.
 h0dYxU6Iks_wSsK6usNTHV5WW6jWpA3UszWXoRzCTP1lNFY8ohKXM1omTI64MX3mmqkThgDTw4ig
 ffzskLGxbGARuapPAqtNWZLRZ3vDz8kQMmBnSVzKZ26GVD2xvk8gi0gAZvp.yk2bZjGj.t9ZvYLH
 ZpOx2KBE5gt2v1DnCNNaw4y90fJwAK3b754kq90IjeeDn0sMkbiRWIqtamfoRr1QkT4b5PY0e57B
 IjAzC0vEtdI4LzjljXw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Tue, 18 Jun 2019 20:54:37 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp428.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b51a2f811968c336d2b8db15b6e3a955;
          Tue, 18 Jun 2019 20:54:32 +0000 (UTC)
To:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Benchmarks for security features
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <d48e20d6-9b47-d081-467a-284c3f5c5539@schaufler-ca.com>
Date:   Tue, 18 Jun 2019 13:54:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

What are the favorite benchmarks used to evaluate the
performance impact of security features? I've figured out
that a kernel build stresses some of the filesystem
access operations. I've found perf and sysbench, but they
are pretty limited. lmbench used to be a favorite, but it
doesn't compile on Fedora any longer. Before I go too far
down the (wrong) path, what do y'all think should be used?

Thank you.


