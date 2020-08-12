Return-Path: <SRS0=RtEY=BW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7E2C433DF
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 00:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B29208B3
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 00:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="l2MfoNhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgHLAju (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:39:50 -0400
Received: from sonic312-31.consmr.mail.ne1.yahoo.com ([66.163.191.212]:35576
        "EHLO sonic312-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbgHLAju (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Aug 2020 20:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597192789; bh=X55CHZgUH+2H6I3Eidb8uB6autfMkq1CCr2G9ZWW/7Q=; h=From:To:Cc:Subject:Date:References:From:Subject; b=l2MfoNhCqPemRr4NzRz1NvACxS/zJ8VXYEkGO7JYtsOr8JxFfWL5MjkHHNdc8RJ5OT7t2iY/EEZiebn2YGcnzJA8srObpO309sfn8YlfQ5Mfx2k90nxOMlYE8nbn8KdH0R25MoLLxiwl6TfYy0WL0QjBnZfRUcocE4RsoV8jvb5XZqP21uRlAM7Cs8RwtR9T6711GXR61GoZYkS5WdFZcDohCvFQJp2x70vV1Qtp05ysm0fE9qac/XvOpF/S29GpGJAYdmlvvO9+SBYY/x+N266H5e1yhzyTHNn3awo1Z2UrZKlx3bdjRaK5HoBmiEuGmtEfjR/NMQwIcOIVwpyrRQ==
X-YMail-OSG: ehKeaqMVM1nPs1ym.uhG4wkI3pENMQURckci4BRHzUgOUzgl64ImaL3UCnsrkFO
 Kt8jOEMFM1AuGbX6JLn462j84tNrDiOaaRBojGU25EQGRY87rnUItQxtuZcjc_SEUML6QLoOKUXw
 vadqSZ3G6SU44vNl_J6vT5N9qHPw__9k9Bz928T_tl9ZfNv.bhnuAO5IZaDyNZxiN1rWvNJGJR9V
 HT6.ASvDGoDgQ2.TkPYTZB5o7CO9r.2osp8piDefKV4WRtG4rpA3pep5N9Kq03Co9dyU0AdvE34m
 ogh6T2QYlhMNHc11Azpkaovl6KL3kc0NOn8ACeYnySI54l7LPAVhxjr2GngkZSzaiIFE1vHO2EW9
 cgaJEGOjfeFHN9ga25HwAAvP5smaXTcO5nHwxDqsPxjOYtUvR7uN2uiOC8W3qmtx3M6eLKK2ZGfk
 xTdSIPFCNyzFgCCClKDoRUAo8wzkXOC0uCY4pjALYqslssr50EWvtDrcAwpfVUgb8NEuHeaQHGeR
 lpwdkQkQMuit4HOyh9HmzRbPTySlaaHF5f5yOJ9R5u95MHpyo3j.dmUaRmiTNXYJVCqQ6SS1_kjF
 b39VmVGagX7obzldNaKKb_OtdjA6RjCTVV85t_aC_Luji3aj_pcNziqQa2c2KKdjdAHhxqXR92j0
 WkE7bN1Nik9iw..op2NEkI92wnxu34Q5DPVQjTc.ALZBDLk4qL07zPCKHnkeGOimcC.bbQVJSV.7
 fPDzLarh_aVAJgez9YMghcNK_oz6lrtO7I3KPFKKAHOPWiYrQ9y2Ae3o4kAGnjbHUXlxOrN7WyMs
 .fYPEvQbhntqDMlOWykRBBr2RwllXQDhLWFZXjNbDM1Gx.RCVddst8yXI4CEYYmaeu5J_c1BiRkl
 HruTbJBOfw_FyGDKIQr8Hldt4D1HWWG8DuKY3rlUU42HXUSEroN4hn9IUb8gaL_BRrIPXP8RIgXl
 b4_aKZt2Tcotw6zFcHxYe5hfxN4zoJB0LGzQnNpvGu97fpGo77HCqkDIuJYxVtx6cBK8k0vBuY8H
 MgQ2UPJeA1eEeI9480xmG2bDTAlJINeSIzjUXQyCZpT8zgzMmYH_8mn.5DMGV4by.4aC3KtG79nK
 gK58d75zP2Tu2DR5vS9U.GYCRdH4_IJzgnmJ3PDmikcd7AC1xZg8DcpGyRiNDSqSxK3begOmlmYb
 vk6Z79BsY7Eq.hYo2vPbdntEemiGDH1ulitVF5Gn7XR6l9fLGqn.tNerA0Mtt39KNe0dbD_Tmisj
 Jt612d0s.dExUvz26eOwlyhjW4BsPLrE_10CGKcgdSnflc7ehBEz3OTTLL8VMB5oPoz5sxwauguE
 5qSZxSAUJXSJRDgxAV_SdLBBHP7VzHms7MvB4A8iSgF4ElVnWMyIOSIVnp6JzsffH4y7ipudOjC8
 5BmpK1FRT4mBhcAl1b277YWYpFXyShveU1SSoTws2bxlgg38tBbZlZnLvZDlsHYA5WX_2cYeUMm5
 YqdVlLl_n5NJBnFlcl4QPun__jb57
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Aug 2020 00:39:49 +0000
Received: by smtp409.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 218b5529a2498dd1dc12082bbd3630be;
          Wed, 12 Aug 2020 00:39:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     SMACK-discuss@lists.01.org, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org
Cc:     paul@paul-moore.com, casey@schaufler-ca.com
Subject: [PATCH 0/3] Smack: Use the netlbl incoming cache
Date:   Tue, 11 Aug 2020 17:39:40 -0700
Message-Id: <20200812003943.3036-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200812003943.3036-1-casey.ref@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Update the Smack security module to use the Netlabel cache
mechanism to speed the processing of incoming labeled packets.
There is some refactoring of the existing code that makes it
simpler, and reduces duplication. The outbound packet labeling
is also optimized to track the labeling state of the socket.
Prior to this the socket label was redundantly set on each
packet send.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack.h        |  19 ++--
 security/smack/smack_access.c |  55 ++++++----
 security/smack/smack_lsm.c    | 245 ++++++++++++++++++++++++------------------
 security/smack/smackfs.c      |  23 ++--
 4 files changed, 193 insertions(+), 149 deletions(-)
