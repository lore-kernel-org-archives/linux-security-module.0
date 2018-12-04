Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861B5C04EB8
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 15:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474C3206B7
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 15:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="jAtZOqLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474C3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeLDPfy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:35:54 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:33262 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeLDPfy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 10:35:54 -0500
Received: by mail-pf1-f172.google.com with SMTP id c123so8405257pfb.0
        for <linux-security-module@vger.kernel.org>; Tue, 04 Dec 2018 07:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UvK/I2BfqqS8rMgpRIKq7mC5p4FD6kdAHno2VhReQc8=;
        b=jAtZOqLFPZ0PUFiSLrKLBurEbNF8VeJ5T8T092s2e6o/qFqGC2z8VxifEPORk1/U8D
         4Bi9nWBRXZSspd8eprYDuUg48spzNsdTVDin3fMfqic3mQDo+1NYozmtITTeNnvAg00+
         KE9MfcHOXAP/uYO/AT8yPS/xjPprxucT59JB5zTcKy99tibD/NjY2q+toudhVNjAmAap
         sgmVVF4ExUi8LmTbuTAntJV9zsLG4Ck9vg57+MZdCsIHBGlLxZk6NZ1cFbYFLGwsOn2Q
         ANP3HwazP+OwCTQAnBwDjxSoLW+n85PmxBIYNVbZ3+ef0gv+hsX5w4g3E1WlYSTrqF0Z
         9HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UvK/I2BfqqS8rMgpRIKq7mC5p4FD6kdAHno2VhReQc8=;
        b=dKeuq+E4N06qq0OGiXofvtLicNgmkX//pMaEzNIJxs5/CTbVfTLYwuWE53aLtdUG4A
         YZ2MJCZUxYfkdR/RBfyOMfcxyJwyOM5VwxYs7TKqrpsXdpYTRR0SLwSS9zOiEn4pn1sY
         28LgZ18L1gfQvxL5aWlUC5AZfyq7ab1H8XmZC4u2cTwek0q+BO5DFbTA10SV/OdTcluq
         D1DiYTYRGdREU18FG3QBepdN9NZHbLRel0hSxsMT70oegQ8sAZY6Zq+lw5ggQ7D69utl
         BGBJwrxL/BuOuK5EDjjd/OJrs4KI69ripBeve06AdHmz/tdTBBF8dz4uynAA/TAIIfRs
         /2lA==
X-Gm-Message-State: AA+aEWZCff1BoDaLOMnlAm/qqe/JCKPBKgTkqgN4UDVIPc9hbVOa9cUu
        PUI5t12c4b2Rc/GAd4b2I6O27g==
X-Google-Smtp-Source: AFSGD/XVSAAJHigN5wyP5jTTpAQg6azVh0HFEp3ajPWa6jWq2j3oI8dKzUdNh962dhpktC7DJ96p9A==
X-Received: by 2002:a63:507:: with SMTP id 7mr15636789pgf.411.1543937753796;
        Tue, 04 Dec 2018 07:35:53 -0800 (PST)
Received: from ?IPv6:2600:1010:b01a:6438:c446:5087:16fa:e142? ([2600:1010:b01a:6438:c446:5087:16fa:e142])
        by smtp.gmail.com with ESMTPSA id q199sm49519069pfc.97.2018.12.04.07.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 07:35:52 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC v2 04/13] x86/mm: Add helper functions for MKTME memory encryption keys
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <bd83f72d30ccfc7c1bc7ce9ab81bdf66e78a1d7d.1543903910.git.alison.schofield@intel.com>
Date:   Tue, 4 Dec 2018 07:35:50 -0800
Cc:     dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org,
        mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7896A3D4-22B3-4124-BA0A-ED763128C5D6@amacapital.net>
References: <cover.1543903910.git.alison.schofield@intel.com> <bd83f72d30ccfc7c1bc7ce9ab81bdf66e78a1d7d.1543903910.git.alison.schofield@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



> On Dec 3, 2018, at 11:39 PM, Alison Schofield <alison.schofield@intel.com>=
 wrote:
>=20
> Define a global mapping structure to manage the mapping of userspace
> Keys to hardware KeyIDs in MKTME (Multi-Key Total Memory Encryption).
> Implement helper functions that access this mapping structure.
>=20

Why is a key =E2=80=9Cvoid *=E2=80=9D?  Who owns the memory?  Can a real typ=
e be used?

