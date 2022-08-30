Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5C3ECAAA1
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Aug 2022 18:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiH3SZn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiH3SZj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Aug 2022 14:25:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7B0501B1
        for <linux-security-module@vger.kernel.org>; Tue, 30 Aug 2022 11:25:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gb36so3032604ejc.10
        for <linux-security-module@vger.kernel.org>; Tue, 30 Aug 2022 11:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=QJ/OiuI4DAIU/nvsqJ29q+7lcv0kq+VkdlITdSVk2Jw=;
        b=PyC2A9aEaUgmS981Ey+/hFik2Xfa3cYwFT6//exlAKq2+bknq2gdjnq+XWo50YRbCS
         Edx5+Hz3FBWAy+CPv46d7PVMaEsLlPPXDxg1HfggtN8J9GtxvkaSgQi2uGb6vhYMbFwO
         WLu3TLyeiUktiTJBP7lTs0BwCuheXsRAgNfzW1Pmcsv734jHg3e2tCuk05Q7jHSO+WFC
         XNwplVmUEjVMwOakJeg0i/m/zZ8Vla6DfBDnMnlGy+8prlmhceIPzjZgu8K5kOYIVH3b
         MTN97ByOjO2t3xjJQvEbM1b2NtefiWIxPDtGfAAZG/wSdjFhuIrIbZBd2rziA+Gv3o2P
         Aygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=QJ/OiuI4DAIU/nvsqJ29q+7lcv0kq+VkdlITdSVk2Jw=;
        b=v2ZPvoBAfsBiI694eBspIso43IysfxDGMHD19+NXc63fSzfu6VUTnRRGdzr8waAuWz
         KwoyiDYc2ZfREViQl6ydMffmBjKi1Jm9prJZ+eVxSZNDC/7JpSkGTCPvpcQcxxt+LwFO
         ax2fEPQFcOgp4wVECz1nPQ4uWGclcMukmOfdZFzk32rTZL0jLR4Ya7tSs3OECcp4Rlzw
         JggfPbgmTUiOzRyHrUq4rI/J7b/2HJniN3X0Md6SnfP3xF84Jwzkvb8EhXqEOz3SOYuA
         gm6yfqMZW4v/zR45pqUmbual2fmkkzIm9VJ2XA2oUD+stQpsH58fNsgPj3L6+FbyEoJQ
         m8kQ==
X-Gm-Message-State: ACgBeo3/iSTcLsQ9vVFklLeZjHLkIsKlE+mNuEU/TMG7njx9s5s98s+M
        bOhP+JURjz2XXed68roW5gp94C8gTT4=
X-Google-Smtp-Source: AA6agR5WXR+ZjpE+IPXpwOLqPiVd22qN4kOR86jHc5BUGP5uW69M5v8dbUcljyKCCnXIK+nAct05HA==
X-Received: by 2002:a17:907:628f:b0:72f:58fc:3815 with SMTP id nd15-20020a170907628f00b0072f58fc3815mr17969997ejc.719.1661883929118;
        Tue, 30 Aug 2022 11:25:29 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id fv29-20020a170907509d00b00711edab7622sm6128914ejc.40.2022.08.30.11.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:25:28 -0700 (PDT)
Date:   Tue, 30 Aug 2022 20:25:26 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1] landlock: Fix file reparenting without explicit
 LANDLOCK_ACCESS_FS_REFER
Message-ID: <Yw5WFjiRBTiESwcd@nuc>
References: <20220823144123.633721-1-mic@digikod.net>
 <Ywf0okWNl4gRXTYL@nuc>
 <bd085c93-5814-e701-bdcb-54e9d5fbe8db@digikod.net>
 <CAHC9VhQy9nf+v0hp3fVofPvf3vTsWWor-fexqXLi+42CKSK=gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQy9nf+v0hp3fVofPvf3vTsWWor-fexqXLi+42CKSK=gQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 26, 2022 at 10:39:56AM -0400, Paul Moore wrote:
> On Thu, Aug 25, 2022 at 6:27 PM Mickaël Salaün <mic@digikod.net> wrote:
> > This patch fixes the (absolute) rule access rights, which now always
> > forbid LANDLOCK_ACCESS_FS_REFER except when it is explicitely allowed
> > when creating a rule. Making all domain handle LANDLOCK_ACCESS_FS_REFER
> > was may initial approach but there is two downsides:
> > - it makes the code more complex because we still want to check that a
> > rule allowing LANDLOCK_ACCESS_FS_REFER is legitimate according to the
> > ruleset's handled access rights (i.e. ABI v1 != ABI v2);
> > - it would not allow to identify if the user created a ruleset
> > explicitely handling LANDLOCK_ACCESS_FS_REFER or not, which will be an
> > issue to audit Landlock (not really possible right now but soon ;) ).
>
> I like this explanation much better!

+1 I agree.

Phrasing wise, I'd also recommend to put the summary first, for example:

This patch fixes a mis-handling of the refer right when multiple
rulesets are layered. The expected behaviour was that an additional
ruleset can only restrict the set of permitted operations, but in this
particular case, it was possible to re-gain the "refer" right.

Does that sound like a reasonable summary?


--
