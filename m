Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63623FC68
	for <linux-security-module@vger.kernel.org>; Fri,  7 Mar 2025 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741386395; cv=none; b=uXEKdauU2yTnRtFBc4iHl9CMQVDKvkLPsLeow1b/qM7lu8ZDxAwfrVy/advBy7D5r6saAPsrsucSVXdkZUWSdwvJ4QiqLZosWCv4eB0v7Icm/OHfktEjZwD6AOJrNk+FW0b7izzolBFubzZp3mDZZhkXcYfyXkHg+Jy4dTXS0oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741386395; c=relaxed/simple;
	bh=JL7Q+p2q8Zqd3KRa0mZO/zx6RzDkk5V+SRWW0awLKQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvqssYNbtL5EePWMZdv6hPaSakwyO4Kf348Myk/+KV+VdUVIJFtejBR2sC2GZG9cK+VCG1N9JWtdCNh5V1N+95sq5gdU3k0rfMxJyPq8CX891kg1/+ETjti6pMT0R085geN8hstoVaH8ogduKcePFuVLgeXkRGy33NxX9Wtog6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=IpolEB0J; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IpolEB0J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741386392; bh=wR1tQOIhN4VwM9E+bmg7/iMkBoGSmvvzPHrn0ltximA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=IpolEB0JEQ7QaT6zAKvk8lzagWJy+KiBgdZ/1AjNBvqUIateo2Ny3DUQx01wPB/8hMfdsfDnvFjwdnNhfgyNGmHraEGAzfjSlvoR/DSPdSlDy49dhW1ksy0wkd2ooXiDitks2j5GkkN7gAIPguWvMP30FVs2hDQD3t9WqgbzqOlUUcL9/2fh7N1jPaCx4dN8hG4Q3nmWegqCzoGymj8TQM8Ja8saLgsesF1pqIzPfRqepVMDwTJ27+ptRwCtJcgdZujhU44cZmF6355ouuOWTHdWSn3G0r7wePBVnxqDjVHF94UpgT9wDZ8vYF5qXcNp3AycLoUYZENucweGSCwpNA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741386392; bh=O0zm/PjvBztjBQB3FwXQWrS4eNKxxLLYsSF82jh/TER=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=LfXOIwq21mDw7ld8OPF4JgmY/fspry3tlnarhxvhFpKco3hnWgcu1JijpYFiLBqmtKkxhwiAin/6kAgO9jf3eJILHsfkxEQj/2OWWllUgCE2idiCfkYxI4O5G6Yfz0al7m22S0si9PJz9XUPaYzlu4G05gFq5keYEhPz1t2cZR2eql29nsBqTC4qdh7tjvKFU8AovYNQTV3XU8C9EicvuH2kbgd8DEZ93Gs8u5v8mbjFCOVJU/UI2Kaa2S1YeHGqzu4SlSqxsFTqm6+A4Mp/+L+ypxuRoo6EAF44O+WnABmv1RICCRTFI3pTQmhu9qdAE937ms2Af8nVyIbtsDpH6g==
X-YMail-OSG: pBKM7VgVM1lCwVyR_xx5.gxAUlW3Yps4N2pEBtJyJn3hqWAc66XDC4DyFruAjy3
 uWPc1NVlZ2orpZormU.m2cm14sts54EIcJKvbmSBwdSKG5vuDgkYUq9h6BCOsOIkx_2chQeVLjKx
 WSpTk_yIb_A401vSKt1nem3ody81b_XcSxDJM1c5c4l3sUiLTLgi._8gPiRvpmKJRbWseY7Ju.K_
 hA9X.D99hXVe0tIlCQetCKWQtKfs9quNFM1FNKTySxSClo8utDGwZ_vEZvc4ev_QQowC68iFSIOu
 o9thJKfpf.C73RHP6eZm6GnHkX_H.NMM7Aq5gtAXvA9e4NULj.oYgSFpju0U9t2N2rPLLmpMf0AR
 Hs5zOGFb66L3A.UfzE1KVLBayfPTP3HJdLjRYZRK0M2g1j3CshT2SXr0.wuWdCi31YOW6S7Xeg6o
 4_p3oQEFNCJhMhT9wDQtB_pwoFlY2XUS.HRKAamk_P.6ZV7xFw9A7B40EdLoZ_uj4ThxEXRX1bom
 1.5GD9sd0u5CR9eytSMK5i27dwLN8PUsvvyksXv5pHWbx4zYnnFytFSeqrbIJdDt1l_z3vfDa0Sj
 QJ0cKjXwTUb5WdqmHeI0GNeVExry7HXW2EkM8yjD41m4.vlq1OVNIi5FhX1nQPFxCuMGZhiwBJ_7
 MoagelwA3zJKn6sxIqSzGQzLiCzadCDAO0z9_kbNmo1NwLaQTE7SILZU_9poBt.SdtZ8J.5elbb2
 vvxfQTvh2iOxMPC8APtqHpWQXiGNPGJFcbHLnbfl2l2htKXHguQCDV4DUrRm7ajhXGGfU2OTxjQj
 GvFSncnu2JgDvTefyp3g5CDBJUXCG8UEiEAsR0g0969mUykIbVzGS6JnWWs5x3HxYJquRRyq4peA
 HyAY_d4_53n5ocnwc71A4lYhEfMpLJpUs_emZ0gMkBCtOM3tjtcldrvnTCoPg698xCQviYBiHCMp
 azkUq083eg83alTq6LYUHJ4h_uJQoQiO83b5CJVW_TZGVdACyGannvCnSY5lrXTwpew.mdf7Z.yn
 YcyctXOCP08HF3YBJ0T4xL8tn.S5XycxEqTFqProRnIZ4hW7_iE5_9op4cBZbvvrAXSFth1tYlc4
 AklTIO6mQ05kvdClggEOwfjXuiHpoVSnNQEVOJrQQS9OYG8.BkMnjRvFwb3u.F66lPm5y4IW.QiJ
 YkPDa6zvkHtjhaPycr18C1hLOYuvwe.tiEFGTwdgiH.Oq0Jmef70f5LpL9xPdiFHd6XJoBB_I13n
 NyWgxoJxp4qj0koCxlAhOAy_Jmlgf18HUEzyuIAlZotYXXbsOQRIUHkjWxEBRKK33JjvB4spGlq_
 FpYV7Des3zHfuA6FgC5tIoDmwpXMgI.YEUsdhjtul9E2WESQnek4xvnePKcWLfgY85booz8iNPxN
 U7jL1q24x1B.5CjrsNV6NGW.f8QKIqmA330pjSxmvxPYxC0vqg8h7z1IfbfGXKlyDBizouK5PMvY
 DnfF64o2.D3dD8mQlTu9SEpdsDedWYJ1uHhjGu.D46LJAE1.8ixZFhPQcEucRd0lCCFoG0OITVHI
 Prd1bizwk5Dvqd3jnhcNEMR.yfNB5RIQu4o3uHNjcXlSJPrWEPNddn8CNB_UaJNVMyar6JybYIdB
 rfT9U1obi0nxc0wWQthiQ9GVbrGZxro.roaHAsBPhCthPRwk9io58CM62whDN1IWbglA7Q4cOUEt
 6jC8nsmVnfAzXq9ysMylUPVlPabQ.n.j9szUs8TOzQ8lTrDxdho3FOuE_.FXezDytPm4XGLhCaz3
 SUzGJvpuQ4yyV8uphd8SSwVVBemt6YTG_A8yesmyULQfupUdH5rvXL0gmNJT9vw4.B3mztBXasc2
 8TFcg3PQZ7BB37MF47g.f3xi8v8NqoA1hFkRdwEOjggHJLdcgZYCjHjdliBG4jrUsrikZV1sb_zL
 HOAHoNi1iWYk0ZoTn.htn.LG7ESqlDl1GlZg5yxZPZWJthRmcqxUkDZBHGqImXIYlsYVUGGmWh1s
 Q_tR.gQ8rcj6HvqQNxV3sagib6K_KlyRxD12_9Hr5Djd5oykFQBHA5fj790Rx2Xo760GXW5dJUBk
 PemAakf1KclhMtzjrzrOrN5LZPrVmhGk3Y_ziJKee.0nmpQOYjuBlZSJdU8VfUucGmOkdOE67R6i
 8tX9h8dsCU24S2X3yGYa6JpFFnvdhSKBxjn_8kdwtcsYN.7kMP.HqE6OqSW9ON.swtZSMEVZSaq4
 Rwmly.l8M3SxYkDOCno9.pytNgd1YTieVz1LSsg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 10530117-7e5c-4b50-a684-6b66c8058aff
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 7 Mar 2025 22:26:32 +0000
Received: by hermes--production-gq1-7d5f4447dd-bx5bp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a75a818dfd10ccaf53784a09c9121a52;
          Fri, 07 Mar 2025 22:26:29 +0000 (UTC)
Message-ID: <35b6e4ee-e14b-4cac-be29-3d97ea74466e@schaufler-ca.com>
Date: Fri, 7 Mar 2025 14:26:29 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] smack: fix bug: unprivileged task can create labels
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250306224317.416365-1-andreev@swemel.ru>
 <20250306224317.416365-2-andreev@swemel.ru>
 <2ad83890-f96c-4848-8820-78455d56caa2@schaufler-ca.com>
 <ee317f30-0626-413e-9b38-5bc75eb02d7c@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <ee317f30-0626-413e-9b38-5bc75eb02d7c@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23435 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/7/2025 11:45 AM, Konstantin Andreev wrote:
> Casey Schaufler, 07 Mar 2025:
>> On 3/6/2025 2:43 PM, Konstantin Andreev wrote:
>>> -    if (skp == &smack_known_web || skp == &smack_known_star)
>>> -        return -EINVAL;
>>> +    if (labelstr[1] == '\0' /* '@', '*' */) {
>>> +        const char c = labelstr[0];
>>> +
>>> +        if (c == *smack_known_web .smk_known ||
>>
>> No space before ".smk_known". I can fix this if/when I take the patch.
>>
>>> +            c == *smack_known_star.smk_known) {
>>> +            rc = -EPERM;
>>> +            goto free_labelstr;
>>> +        }
>>> +    }
>
> This is to align two ".smk_known"s in two adjacent lines.
>
> I strive to make monotypic operations visually monotypic.
> This catches reader's eyes and lets him recognize the pattern faster.
>
> Of course, If this spacing violates the rules, it should be corrected.

Yes, the spacing violates the rules. I don't agree with all
the rules, but unnecessary whitespace isn't something I generally
approve of.

>
> -- 
> Konstantin Andreev
>
