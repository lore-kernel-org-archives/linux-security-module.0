Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E17284B59
	for <linux-security-module@vger.kernel.org>; Tue, 19 Aug 2025 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631156; cv=none; b=J+zqlD5VMUmZ6ZpykxJLfhPxoEI1OFAcx9rMhStqlU+DAsIBAg1NVX/+BDc4XO9EimFfKs+1Z9KIc9+7SeisGcKguJPym1Y6lwKqTA3z1hfd58ScgUMHMz2gKmKQoWhoa/T6aoz7CeONtp1y87iDtxF3FbAUoi2SkRGuNphCAxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631156; c=relaxed/simple;
	bh=nDtZD5FSmG/CGBdUNE7KHpOsJwsBrvENXVA3O410/EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QG5tTeGaVPPX2F0eKhn0RC/OMhWz1AHobhvcmSx6IXoecYPg5XCh4bIQo8B6u0d1VnrW2dA25YFUtQhq1RRS0oNbo8ZoccehkVajz8Ywe3nwBxEOvpSBa0OPAlwjNL/ls8nwK7lpUsXv3+UMW8H1vA+oYjARuN+bzDEthd1qkv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SK75aR/U; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SK75aR/U"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32326e5a623so4697690a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 19 Aug 2025 12:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755631153; x=1756235953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W/M64oSvf4Fk1SKGFHqHfMPFcbRUqp42HLrlC1xskA=;
        b=SK75aR/UWPu+bcnMFSS5I0DENKZUOKz2w5uZmuhPfe7JAc2WQ8yt9SQdrD9fsMPCH0
         gp8h/3BcQ9VlPMXkc0M9AUm1tWZM98Lpcit4+TCtuHF5pxKucA+Zx8KgOcMObobw/nIf
         HGdGGN1oTQPyshsRNMXqjU8Z5RjLhyJlVS/ee+sajulNV13gXZP8fB42qi80uzyi5M63
         JkP4VuapfHIuHVhCYekS5YU6eCwvTcrRmFXdS6KRFBZ879Madwe6AuY5r6sWC89lHKuf
         D1bQxF2BWNlwQ976NPStEhzrbq4RwEfyZR+NTwGi6tlJMUQPloolBNxLtpep/zUlZZ3Z
         uCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755631153; x=1756235953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8W/M64oSvf4Fk1SKGFHqHfMPFcbRUqp42HLrlC1xskA=;
        b=oJgnFMvAtpyadtCjt3tjyQhKYjftnAb4qCUpsqMDlpzk7xEy+1zGt9oz8OTuTsb9h6
         pjAr5HG+l6+yeGs+mwaf++PNkUAGWjkbq9y5t2E2W4DtX0PJrnrWLsN5irAdP61YvaHp
         svst+S/CqGiLaUoKkuqQ5xYngva8T9Fk9IThrRQ/dP+Ka35Bp2e0mO+2PP1jBXKYSTea
         ZdQ9q+q2ZOK2F3Vo24JYhqBOi8icf0uTSZexN54B9o89+Gl19fHylFGmSCyUQZKoeqWZ
         OxhrbvyHtnWnmtvsGSJV6TopUEwxMOQ35P0yB4hfADx0lApsPlKe8CC8/pxXlzfsmNXZ
         3hHA==
X-Forwarded-Encrypted: i=1; AJvYcCUXNLK+vGL/fZHiO8bxHQ6jomu1QdAV/PeslDAhNwG0qCX1E6NePJ9t6xTBKGFyczco4D6/wSOYgd1e3XBc6PgVL1DJ4Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8FCvjX8+zXr+FO1W+0ltgaWfk8R7g7JGVmEQzQaekl6sgi8Iy
	DWWdSA/4+ImZB1RYoQzNPuPao7oVxJevP83B+SotbKBovJXwihAh5m+xTPfKadtTkau/TKDdxMT
	G9CHjglI7IFIxA8joAl2oIyH9JSR/EJMtMgCVRSSM
X-Gm-Gg: ASbGnctW1xfGs8WBzaPPcMTRXtW4h0OYh2tViL8xBxnHHm9damwB3u1udb6ixV09Blx
	gF8ym1PEbO6bduOYnjZhD7ZzVr3ISMppE7h5G0ZznYgMhgd2l3L+duKwVaNgvZUvKZQKMWfBHXh
	qvwzsgX1App113YfRmrN9RDqsSUN4Mj1YHz8GwSa3tQbxV1bZvSxec3Lz+dbaWw7AXQBxyULsPH
	6X4Wbs=
X-Google-Smtp-Source: AGHT+IFt/MV4wB7eQ5hkwdRDFrUNtetg38g/aENjZTxF6uNMPgcELY2nmhyFsvRjDbiLLTWF6RNjAybGWjmy77iCqZc=
X-Received: by 2002:a17:90b:2fc3:b0:312:26d9:d5b2 with SMTP id
 98e67ed59e1d1-324e117c685mr542450a91.0.1755631152712; Tue, 19 Aug 2025
 12:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813205526.2992911-1-kpsingh@kernel.org> <20250813205526.2992911-9-kpsingh@kernel.org>
 <CAHC9VhR=VQ9QB6YfxOp2B8itj82PPtsiF8K+nyJCL26nFVdQww@mail.gmail.com>
 <CACYkzJ7vBf3v-ezX1_xWp6HBJffDdUMHC3bgNUuSGUH-anKZKg@mail.gmail.com> <CAHC9VhT2Q4QOKq+mY9qWHz8pYg6GzUuhntg1Vd-cpGcQ7x6TLg@mail.gmail.com>
In-Reply-To: <CAHC9VhT2Q4QOKq+mY9qWHz8pYg6GzUuhntg1Vd-cpGcQ7x6TLg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Aug 2025 15:19:01 -0400
X-Gm-Features: Ac12FXxvAxNrILnesY9oRSkXSP2x71I8_vwlv_1Nd_1NvTJP0yyJUdWY-g0WNIA
Message-ID: <CAHC9VhTFF4gnc2Lu4XOkA+20sQtcvG3WgmJnXN4eiPSifc-+sg@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] bpf: Implement signature verification for BPF programs
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, kys@microsoft.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 6:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Aug 13, 2025 at 5:37=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> > On Wed, Aug 13, 2025 at 11:02=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > >
> > > It's nice to see a v3 revision, but it would be good to see some
> > > comments on Blaise's reply to your v2 revision.  From what I can see
> > > it should enable the different use cases and requirements that have
> > > been posted.
> >
> > I will defer to Alexei and others here (mostly due to time crunch). It
> > would however be useful to explain the use-cases in which signed maps
> > are useful (beyond being a different approach than the current
> > delegated verification).

I wanted to bring this up again as it has been another week with no
comment from the BPF side of the house regarding Blaise's additions.
As a reminder, Blaise's patch can be found here:

https://lore.kernel.org/linux-security-module/87sei58vy3.fsf@microsoft.com

> The use cases and requirements have been described quite a bit in
> previous threads already, with both you and Alexei participating in
> those discussions.  If you really can't find the threads on lore let
> me know and I'll be happy to send you links to all of the various
> threads from the past several months.
>
> However, if I had to point to a single email that I felt best
> summarized my requirements, I think it might be this:
>
> <<< QUOTE >>>
> The loader (+ implicit loader verification of maps w/original program)
> signature verification scheme has been requested by Alexei/KP, and
> that's fine, the code is trivial and if the user/admin is satisfied
> with that as a solution, great.  However, the loader + map signature
> verification scheme has some advantages and helps satisfy some
> requirements that are not satisfied by only verifying the loader and
> relying on the loader to verify the original program stored in the
> maps.  One obvious advantage is that the lskel loader is much simpler
> in this case as it doesn't need to worry about verification of the
> program maps as that has already been done in bpf_check_signature().
> I'm sure there are probably some other obvious reasons, but beyond the
> one mentioned above, the other advantages that I'm interested in are a
> little less obvious, or at least I haven't seen them brought up yet.
> As I mentioned in an earlier thread, it's important to have the LSM
> hook that handles authorization of a BPF program load *after* the BPF
> program's signature has been verified.  This is not simply because the
> LSM implementation might want to enforce and access control on a BPF
> program load due to the signature state (signature verified vs no
> signature), but also because the LSM might want to measure system
> state and/or provide a record of the operation.  If we only verify the
> lskel loader, at the point in time that the security_bpf_prog_load()
> hook is called, we haven't properly verified both the loader and the
> original BPF program stored in the map, that doesn't happen until much
> later when the lskel loader executes.  Yes, I understand that may
> sound very pedantic and fussy, but there are users who care very much
> about those details, and if they see an event in the logs that
> indicates that the BPF program signature has been verified as "good",
> they need that log event to be fully, 100% true, and not have an
> asterix of "only the lskel loader has been verified, the original BPF
> program will potentially be verified later without any additional
> events being logged to indicate the verification".
> <<< /QUOTE >>>
>
> The above was taken from this on-list email:
> https://lore.kernel.org/linux-security-module/CAHC9VhQT=3Dymqssa9ymXtvssH=
TdVH_64T8Mpb0Mh8oxRD0Guo_Q@mail.gmail.com/

--=20
paul-moore.com
