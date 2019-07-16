Return-Path: <SRS0=8dNN=VN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB906C7618F
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 23:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BED32187F
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 23:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kol/7OIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfGPXrw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jul 2019 19:47:52 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:42897
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387623AbfGPXrv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jul 2019 19:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563320870; bh=bBEun1LNth4+w3mII54GPV63W8jxaTHT4CAM+W9mKFc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=kol/7OIORNdklPcPYgY2v+JNLYJqBXLR7BHfj6ZafusorHGuCGOZzjLQgPkOFw6npGsEEe2LRk+lHlZVQWsMt4DgGahafbnSqjBJnEg7i2KEyXa7TUCO3b8Wb+gvUKLNTVp9xM35Iq80UMcYOTdr8vAO3PlfyWTpfzcEcGLewH9C3x2crAjcTFkL4i9Gm/ppiRj6lweDATL/L2fYQSRRFA9AQTarurFlX0k1Um7D9gNtUjQg5qiRZ5AKLQFWW4djTrQ8yc1YXrwIAWhDmRjI8jIjJRSWY1Jg3CroJoOQnUImo59Kw063HA2YK6E8zChHBu+s/2LN0ks6TeO9JgMp7g==
X-YMail-OSG: _MWpmJAVM1nmCikE6JgEtKEEz_nOy0B3lTm9ypBmIFIvaktpxQ1YTnJwweUv2ad
 dsVcFegoq_Ws5n9LBIcBaFsNIdGnSnRFekclyaaD4bLOWVkQyeTFzbTZAlNE27UD48UMJGDWuloD
 Be7PHX8gVQ186Ibt9tU0yv1hWQ266AIE9bOs0XxBA.hcSJNep4aoCoZZ1A4YRQ6QeQFN_Kg7h5H1
 r59F1w_emoGi6y.waASJnw9_dl9ozgk4EljoCbWRQsTKhQRcCNZ1P5LNuwCz.gV1BaTXAAILtYn_
 ijkwsDh0p7HSsQF0vczeXLBw03EXRSTP.q6Iw1PrPfXQ2A3KbcBc_XPCnHIOpTZOMWK5nhWV39mj
 JT3dGE3oykzTXqFv.h6OC9oOyPbvjxA5IvtCKpH2j_x1eTGzTL7vsZNp_KG7MDt54XHng0g4Yy4V
 JsFiIrvaigKv_KDTzIR2YRRd3s6CEoCX84oWZk_z19t8UHhWg6.PwmQDZcNMr5lZ8d82ATpVn01U
 _TvUn2QQ_SWbyoSwL.Y3hc5NDkeW3vy8DVfyYWHsc46icJCXqfir0IEHa3dJoGVeldpibHz5UwJ9
 ea9Mr.ShTvrnb3c_bmQOZLhOlUQY1JgozwPB4.eEelO6gkDq4ypeRIWqhEdngqFwB.7D0bEsSNqB
 kF1_pDsbnCtkFSPDAKOl2G4H_RcTT8NPlO_S0RB1ST5ynbW1NWhbhTAVccOOHHfliKCXaYkt1xEO
 cLXy8IE5COZ0p3VnPDAzZj4jzBLZXDN07TaigJvcX45y1axpvCi8pNDBwsfRt9nMLkguZxdNWxnD
 v0jxvbKJqHH4zhSiqD_cArtDu3YTSb8sK9I8ungTnM01ERkmurp0_9WHB_ZtgGPcW.FomNc46gWk
 qu0G.JQzDsc085M5NXXv4AJv.NQt1PmmgXAt15C1d_EH4JS5Fl4tfo3zTP5.Nu0qO8BzPRk.ho7n
 9IRVCzLGKbjN8OXRK2zF5Obs3WpQLPTnGkw3UoGC9g_SYa6bty0kSoNRDShLSXjsK5KRpqt5qQsL
 I_Ty5mfNddZeHBM2RBkfchopb41Xo_JDyU._JVi8Sa5oljNTJnkQhcaRFj.1dSeNgEXphAEdYsPP
 CFUTN3cS_beVeRouBRItYjPYsINm9S1OdlSBB8LHZ7g1g5_EQ7BK4Izds4zGeacACEMqAZsl719E
 z2NCrlelceO68hb5NLtN01j2ZcFg_Ks.w5sMAO0JdtXLdI54UAmt0FpatbfWFoPd5Y0EjJlDOpid
 n4Y87NykeKetFTP9pnY0NbW_f4t2fQaE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Tue, 16 Jul 2019 23:47:50 +0000
Received: by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 57e5d4f063d19ebebb37c62851da202b;
          Tue, 16 Jul 2019 23:47:46 +0000 (UTC)
Subject: Re: Preferred subj= with multiple LSMs
To:     Paul Moore <paul@paul-moore.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, casey@schaufler-ca.com
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com>
 <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com>
 <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com>
 <2517266.eHZzEmjMsX@x2>
 <27e2c710-efe6-d9cd-d4f9-bc217df5ede3@schaufler-ca.com>
 <CAHC9VhTpcnyGg5j3b6Z7Yi0Ob01JETRiBmz1AuLqPWqP9tEAnA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <5ea2a25b-364f-3c30-79c6-cfb18515d7ba@schaufler-ca.com>
Date:   Tue, 16 Jul 2019 16:47:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTpcnyGg5j3b6Z7Yi0Ob01JETRiBmz1AuLqPWqP9tEAnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/16/2019 4:13 PM, Paul Moore wrote:
> On Tue, Jul 16, 2019 at 6:18 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> It sounds as if some variant of the Hideous format:
>>
>>         subj=3Dselinux=3D'a:b:c:d',apparmor=3D'z'
>>         subj=3Dselinux/a:b:c:d/apparmor/z
>>         subj=3D(selinux)a:b:c:d/(apparmor)z
>>
>> would meet Steve's searchability requirements, but with significant
>> parsing performance penalties.
> I think "hideous format" sums it up nicely.  Whatever we choose here
> we are likely going to be stuck with for some time and I'm near to
> 100% that multiplexing the labels onto a single field is going to be a
> disaster.

If the requirement is that subj=3D be searchable I don't see much of
an alternative to a Hideous format. If we can get past that, and say
that all subj_* have to be searchable we can avoid that set of issues.
Instead of:

	s =3D strstr(source, "subj=3D")
	search_after_subj(s, ...);

we have

	s =3D source
	for (i =3D 0; i < lsm_slots ; i++) {
		s =3D strstr(s, "subj_")
		if (!s)
			break;
		s =3D search_after_subj_(s, lsm_slot_name[i], ...)
	}

There's enough ugly to go around either way.
And I'm not partial to either approach, but do would very
much like to get the code done so I can get on to the next
set of amazing challenges.

Oh, and I don't want to pick on subj=3D as obj=3D has the exact same issu=
es.


