Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30419C4321E
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Feb 2022 00:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243364AbiBBAag (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 1 Feb 2022 19:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243347AbiBBAaf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 1 Feb 2022 19:30:35 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4A8C06173E
        for <linux-security-module@vger.kernel.org>; Tue,  1 Feb 2022 16:30:35 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g2so16869871pgo.9
        for <linux-security-module@vger.kernel.org>; Tue, 01 Feb 2022 16:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14jvoQeqKtuOk6Mr4+0C6OLoJKyxEeffQvdA+jlHBmg=;
        b=JqtonjpTgg0b8htWFsCRcqqN28M/Rj/GjM986XzCkwGftoGXxTfbXInvqAAsMH0z2K
         ugIZoEmIXpPEdLMesDzVJZQcpOoG0EHB5zlq7jSOa2Ni3fWcKMLBUd4BwWt2PdSNJmAr
         ehPwqkv1CZcRE6T8hbQJu+GdZKZuoCx0531OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14jvoQeqKtuOk6Mr4+0C6OLoJKyxEeffQvdA+jlHBmg=;
        b=cDlmzmzQhQqMlpBb+bhT35j9Ef2oV2O682YOTIk0AKEbVtFCdXzKqIH9Bq9WW9i7cB
         wEPzmrFUy4/24LvypF0RtX3KscrLe0LOF0m3z6GsT1ycVLEIKHjG8mKSIIOQAPDqE/8G
         BaWHlEbhuF6azEQU8RZbppwqVzHZhDE19GbsPYghSau+mkTSQODUqRhBDuuAhfIcSwdS
         a+Nl69EWrBv3JbbxKrTmCcCaAm4ZWus4ArUucyLCHfhUywVTatE6u57gtKR5olLcO/4e
         QUeEmqXMZoLpTpjSWNeaVKU2GPsLBpji+jxQfdzChVvyZ5+vTrno2Bba1bK0PFNXqujJ
         AHPg==
X-Gm-Message-State: AOAM530Xsq6OIk6cxoFYwPumxCaSWzVLxlmS3LI91yJ+avP/vkbADNLL
        698IEXCeeC4OUZlqCvshGbIXpA==
X-Google-Smtp-Source: ABdhPJyPbhjJHeF7NXhuxl1KHgGfYpXz6s1ERxX7MxNSnV1oyBrhE9RaU2+8dmrYIQVnmWjyfe1wfg==
X-Received: by 2002:a65:58cf:: with SMTP id e15mr22850329pgu.172.1643761835332;
        Tue, 01 Feb 2022 16:30:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bv22sm4184717pjb.31.2022.02.01.16.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 16:30:34 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 0/4 v5] fortify: Add Clang support
Date:   Tue,  1 Feb 2022 16:30:29 -0800
Message-Id: <20220202003033.704951-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; h=from:subject; bh=6KvsI71PT+JlnQyQ662Nyi7JCW7rzErZj2gDq9QB56U=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh+dCnjHLnvpGi5TnrdR8f2ys13IgaTmLG1sJwJyvB 7ooS3KmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfnQpwAKCRCJcvTf3G3AJhytD/ wK6WOdEoT2YI9H0XjDjQ/NualqA3pjJoYJrGr6Vs8iaBcQw4OAQWxg1niXGY7FxYMz+tmE73Tum6IC 266PDWnqdUm42keREwroQbd+kwQ8kS8XvOwLkTJT/i4Ooef23B3t3mNn8jusyNbk6ZJLzjn1d8s6NY JwQHFXGZA69s2hmMxc5TEsjDRUiWYyNajkmBxnMjj/3jdqsgEuOpOJFdvLxFZYJbD1vOxoHj0ZSafC lAOPsUXrRmLTQu+ApRXnq0u3SAGIDkNVtZKUDWCvafyLDlmeXpJtriZ0tPpiN+lmf0uN6nPyg2FFJm Wmlzb1fOBOVgnBVWWXS5r53d1ytpzfLEe7pX5hDoxopvhbRv8Sl7pQj7GRPyJzJvnA6x0j4pn8to0a Qgrrg4CIAQz969JG1PFmwaYD6stOAOr3bDDl+jwQG8qyZ2BCzpfo9oYfc2Mj9U3RFZ1Gpf0H36l2yy Q91IkhfyEO4soOai0LqQW65tEFt44I1G3+ugq7ct1yixYCQUtPQhXHSH1vU+0ioQp68DeC5j6AFLgW NPe3MhwmBwmiwIi5110A0RXhJFMKJigIRPkuf7q+Za9pKKimsDtmV/sX2dlnUyoM75DNEqStVplmzd EMCBO8FeGOhI3wXXPk4bDWqhgPGu7kGUUw6NW4XFAfqm3xxz6yrgNu+7ZZHg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

So, after looking at v4 at little longer I decided that it is just too
invasive. After spending time researching the primary issue that needed to
be worked around (__builtin_object_size(p, 1) not working from inlines),
I got some help from gbiv to use some Clang-specific attributes to get the
same effect.

I think the result is much less invasive, and it even lets us easily
expand size verification coverage into non-inlines if we ever want to.

Please take a look. :)

-Kees

v1: https://lore.kernel.org/linux-hardening/20210727205855.411487-61-keescook@chromium.org/
v2: https://lore.kernel.org/linux-hardening/20210818060533.3569517-64-keescook@chromium.org/
v3: https://lore.kernel.org/linux-hardening/20211213223331.135412-18-keescook@chromium.org/
v4: https://lore.kernel.org/linux-hardening/20220130182204.420775-1-keescook@chromium.org/
v5: - rewritten to use Clang attributes

Kees Cook (4):
  Compiler Attributes: Add Clang's __pass_object_size
  Compiler Attributes: Add __overloadable
  Compiler Attributes: Add __diagnose_as
  fortify: Add Clang support

 include/linux/compiler_attributes.h | 29 ++++++++++++++++
 include/linux/fortify-string.h      | 52 ++++++++++++++++++++---------
 security/Kconfig                    |  2 +-
 3 files changed, 67 insertions(+), 16 deletions(-)

-- 
2.30.2

