Return-Path: <SRS0=OZUD=CP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4835DC433E2
	for <linux-security-module@archiver.kernel.org>; Sun,  6 Sep 2020 14:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5FB2087C
	for <linux-security-module@archiver.kernel.org>; Sun,  6 Sep 2020 14:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aq9r46vI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgIFOUp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 6 Sep 2020 10:20:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:50303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728891AbgIFOUA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 6 Sep 2020 10:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599401997;
        bh=/6GY+vCiDq3r2TFREQwT9xodDtp5h9Zbvasvf+ukhDc=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To;
        b=aq9r46vIU6b2ST1PXWAYvsRpefCsFLwACAAMiNwgCO6dTAxQgtYjQ/vLEDT/3FCg0
         uYX9EWP1YKbCfVyF04P5flttiB6OP4OwJCSleJ+SHcQIy/nr19vBi2LQhtj9vkpSJX
         HGcGmI+4g6uiU5m8M5R92u69v4mNVgf/5A5wW1mE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNKhs-1jvc9n0az4-00Oqxu for
 <linux-security-module@vger.kernel.org>; Sun, 06 Sep 2020 16:13:25 +0200
Date:   Sun, 6 Sep 2020 16:13:23 +0200
From:   John Wood <john.wood@gmx.com>
To:     linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] Fork brute force attack mitigation (fbfam)
Message-ID: <20200906141323.GT4823@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906121544.4204-1-john.wood@gmx.com>
X-Provags-ID: V03:K1:/vhj176bBf1ATaBlls0fYYpaALcITn3MrfMDw3fKS8dA7EJcOlv
 cvTHX0rUoNn5+seT869Ri+yW2AArELR7t90EUKyKf1p9wT8qa6Vr3eQiVF17L63cdVwXlt/
 aahiObw/LqLG4/CFX7mISN+VmW8H3tLHE6tWYTxjMXXyBxvmgVTR2Ee716JgoBY0hjTTnBL
 8yVOVtJVThS8tHya3aJ5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MKo8UgG87Jw=:Y3ebRzFDQL5dc4/oICLDRV
 ioPCEKtLhd4p/jLZDj+HrLi4r6mxpsh1R76/9Z2enbBhqv27jolt9L3LLJzs5JoZcNKuA4ODw
 +DFjoPmUpuVv2tsFiLc099EMVKrQyTwHVDHg0vmX4mrEHvJcNIzTGwOFdTd2/AawBo/ZZL49a
 9zkC4pAaBPzLSTlMn4NLnLvkld4ne4J/M5YNfSbAZFoTd9IdTyJClw955APfzTPKXLDvP5p0c
 81WV5b/R+1znEm2Giim18AYQwkUR3WIexAkS/U1qOy3tpelcA4iec1vbRJTB0xdnghsjKZjv3
 FaVoBKJF6u2LiTUDymYo6jRvvQt0p0setmkVle3CVPsgNlDauOqRLwo0v8aDsnnUDAdzLj5yd
 fJXcNBe6rqs5V4QvbqdRFdMtYF8iFc13Xa0CEaVQyRRT/ZJZ2PIOdh3zWsqucoGKhSlD0mPd1
 P3r+NZfEZiQ22uZw3gQgtGKh6WxO1ywuJ7N4CQ68YcM5jUK/TLPrJVSpC3BeYbMttvF+OeBmC
 Y4q2w+2/cim7NqChZp1QF9Wn0xfJEJ1Wj5VHhyVQvhMRlBS1n3PViEo7RfIElby6/W9kTTfoJ
 QhMHsiYJ7axiDDPN5dtWOokkcnlTDPF2jCnHGNeDVtMUaMsOMQGeMxocxV+z9zrlzVBEpT+ye
 9fB4bAp98TAI7kTKHEmiPmJZyznp6JJLZk5YzXuMi4YH7/JyNt15d8Y5L0f2Usqf8YhIi4cvf
 UIDZDUOMb2fT1ZbgAK3cvupbNExi5US5eR6WjREJokjnvCvLG5ldHMCgahBvVPsrl7YxRGhVD
 Bl+rCza+VlMHyCGpytZ7SrweIhFlzvYc3QAlWz75tr8i2JcJjn9gfX8undS3VNgQ9zOl0P7NH
 rgvmMPRMVFygfs7/GSwexe3Ln8dNUJVy96IlloaRYssAgQVWBQzYOiGk/AVRX7m4GPznaif/M
 Or14TQwEpLxsufqFNHcYdRAypXhzE16oRMyPJqPORIDgC+1yz5RyTdheZkcjKEtDQkFd75P+H
 Z9ZP1tSM4mahCCVbIw+eUK9+1+kb+kloW8Z8GyNVfkM2+ZFPmv1zWKDuEYmccY4d74aqJOUQh
 zDZ/Ng0YSmd/i/6/evWMG7rxTmCgNxRD47jpvEvg7C7+MWuXHJIO0wBYY3sU4xVkDVdUwRrgN
 kZQOca8Ty8mu+DvI15IST5LGM8HG59ak0Wb3U3rGxBGG7+rnsrFOuNdOyrzB+kGh1r6Lh0gv0
 6JclEibGXzpPtqgMTWtVh2vy7PXooaK7L+MRBCQ==
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi. I have problems with my email account to send the patch serie  [1] to
all the recipients. My account blocks if I send an email to a big amount of
recipients.

Please don't reply to this message.
Thanks

[1] https://lore.kernel.org/kernel-hardening/20200906121544.4204-1-john.wood@gmx.com/

