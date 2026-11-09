Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794255303;
	b=IGFzrXUFVnBLy888UBx3E+TTm5wfZGWWUoULHAT4lMrwRBDwmHi4VuMpCf1lQT6hzdqE
	 zPNoETy3iIK6enDysJtCOu95dbpiI/b7PubiXgHB6m8fbtVlhnKJIOBTAlRkOTug2I+k4
	 DOIfOzbdjiy1LuKDYKa4I1iyvGvYPVLXlooStEZiLi0mgVs1CF2RA8YmoaN0jw5NEdSvb
	 7aCYgia6rvQ2hoYwUMnTslKMwQsEV/6+tvQ6LUQYXsAm6Wp8r9oPP+9HVb0OkMv9RoX51
	 ITLBsbSFMH86/pMuN5oEUe8lXkIkRUXnYMGE8WWlMQXsUj1CoMfQZjq772L0wpP21Zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dcA3JlLu3QaK+Vcd+6otPpngHTSFEBthNfyVcNg6yB0=;
	b=JQSDLFgJIqULqTFvGfa0xwn+gbr8fA5kJWbqyXglIQivnl7CFU/XFKV5DL7uxzb5aC8k
	 HLNY3wDKIYqYaHsc2/u1ffTl59rLnG0F2F6lbNPvoeKoe+QSVOmZiDooLETOfHYNLmUE3
	 xBVWlpqAcIOU5pmPSEt5+SUFRGq0APYWDZKUc4rj7pAmJdfWAA2q1r5f4Qd6qbRvQk/yV
	 NG2EZkJNCKTQOG/UAFEqNXgIPgwljkrh6xUwe62kbXDN0fQ+HugOqYfqOLvx8vcWiCy12
	 ZnducoccNCttSJGn+LDNKbmLGwgwHfZv3Pc2iCnwOMWDmvi4W13PvnlEFTbmN9s+1xQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=JM3aG7UD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF85606A339
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 20:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EF85606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=JM3aG7UD
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b8ecfa886bso590918b3a.0
        for <linux-security-module@vger.kernel.org>; Mon, 09 Nov 2026 12:15:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794255303; cv=none;
        d=google.com; s=arc-20260327;
        b=Qbe1/RvGjfKo1vsH8c20PGzXA32dV2uSBQ9GFiy8vJYdTtNaBVNokofuMVml/StLoH
         pYrkRdrwp7s1MwQH5LW/ZtC6O1Z6wDakVdY6NoYUWLYEu4RquAKvq+vM7dwSOitZ+gIg
         cm8Oi7Gdu6C7wUuu4y7uZPpdSB+gOqMQUI8FOPvVpXpVjvscvOaT0rOiQabeSaqPDkgg
         ti9qd+sIr7J7snpP75D7uirxzFiI8frOToCqZl+hAIBp/bf8Vgcy64CqksIRcX91+5hx
         w39ZdyUvjmZHUMaLYX0sHrQbiNZfPM3LO6xk8OqvB+JLHF7YPOpP17bO2RFyJQKOSVIP
         pYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dcA3JlLu3QaK+Vcd+6otPpngHTSFEBthNfyVcNg6yB0=;
        fh=gsy1NCttD6ao74rjMhrtXtvKb11u5qlHTQkkt7W/Lao=;
        b=QwEUAgylGTtFBTT1NzRMFtmVEFMh1ygbUflGZsfJoFbkfBpmr1+iyfNeM1nDwSFm1c
         5+9b72HShspml2GbnBEtZs+s5ZUf9eB6XhOwVMhSiFHxSToTsnPlhHD0EK27JBbhFbJt
         WSZDduwgoeougreZJ/mibplC5V4GqFBUHkRS/bwWa2FyufpEYId+8rNnp590VUxlsNpW
         DC9YcjxKq0aEZaff0iG7cRerTXBv0VN6yFFQinbnE1foFTMtRC/4odOR9jpyXPOVC8pi
         J6n0J2gg6bg0CfGBexJCvmda/0G3Fpj7v7UA3Isw7tD3+VFjjew7CkO9efGIdr0G1mqw
         5x4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794255303; x=1794860103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dcA3JlLu3QaK+Vcd+6otPpngHTSFEBthNfyVcNg6yB0=;
        b=JM3aG7UDhE3ppbxcli+QQzARg2Kk347vy5ytnvpfinkJQjCez8mFUwcYs8+/PrAO8z
         qQXYwQgzy8NbHr19R7sZA4uRrRbYDLtCZTFfnP5xl9j5o2XEJs++ZuMTq6tvsc8/HEJn
         psFEtb6JYK9B1K2UCYWdaKijgaM/Sq6WoMXKjc08cwsZyhvosTpftZa2yma2RSbfY9xo
         Q3vHnPYquzJjxSmB1OqnqGohXqzBVuNzvCn+GTJhiNm7oW7SLON4wQa1VbC7cxzBbOjC
         DAXh9HTRv9+dK3JjCLtk1lYJ3Sq5ALw0klGRsuHQqUUOUkAIo4X4iR8NKPL5u45oL4wJ
         ht3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794255303; x=1794860103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcA3JlLu3QaK+Vcd+6otPpngHTSFEBthNfyVcNg6yB0=;
        b=FPINuA2e1u9/v10WDhPIl3kI1L5VpyPLgwae7otdaZqrsd3V3rX47ZAHg0bDt0KVnI
         P94sWQBsLqPtjt6sYkSsNitSCYQMp78BR4d4U5kN9xHicgD8kocM1XiID9yMqxxxaUbv
         2w9/CuUyLu9KoZ5+GshJkdLG3rDiIFt4DmtO1L6cdaqaa4VKvszHJCYs6mLGYQDFvR3S
         1nuevlK83gtpXOMQVqaSEZccRB8W3R0ZQnm/kd0WNg5sRUOMsel3kq9zT7+7KzfnTjig
         56l9WObwzj5doN2F9zHksoU5CvR1SE98pN8LxAAvPzeBSPsqni9butvPfNrMTRYxUXfR
         65Cg==
X-Forwarded-Encrypted: i=1; AL+hErFQPiHExfWXTIFeZ0HPdHnEdvJnl6CMSG59Iu/beccasqBa3ATYkdr6Y0fl7c63Nvcr03Qb/YQCrypblXUmFXXKq7WRozQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hS3L+Fg2z/QuV/MvArGqRSuQQn24uXQSS6WuHdehaW/rQCTgL
	j4b8/C2h9vTxiBUYIyDWOnI3UJsC/zQAQ0JWTMfZV9t5tC9OXMDp+v9uBKrjoV9Hxta2znu04js
	GHd/h6FsvFCMmedPkb9SDZ3CGkPEHQN+v/Xl6K0m2
X-Gm-Gg: AYBFou33hPwtTteQsz93gJbTui/6qCnd3K+Ev4PSr++VmIw2r2/oHhC+9nmUL9NSONz
	1yY9nXtSQCBFbLw0xYBrRS6Z6R4/yOhuTJAsF83EPKYXo+0sNpPi/TddE2wBwOcAvUOFgb4gfm+
	iv5r67jjbP9updkJ/zmL3/Da6o6iaphIfv0tqs2l5hUA+/05egSmu5kflw3uq20RJc/Ks/jVL21
	hMCjw/NYUPXDEpVQMFgMUK+HEMZ4srNFwV0pXm52uKvRCggapEtLzf3Kzz5lKptFWN3fFV0dls/
	vRZrJTKi+3XwwenRYIARIGAAtPQnS8Mvm5lXofToxPj0j2OQ8bI6D32KwNwZYD7Js3+gtBBTzyF
	Nj6/ar6gTu+l3y9npkcfNaCmVhUTjQifygMDvWNwJFKo4qwKXzMzC5fRKNmQkDXBmDmnf
X-Received: by 2002:a05:6a21:62c4:b0:3e1:4e53:4e7f with SMTP id
 adf61e73a8af0-3f18f4ac9aamr162563637.27.1794255302075; Mon, 09 Nov 2026
 12:15:02 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com> <CAL4Wiiob6K=Y1ne0G+8L6b8fxNxdCz3z+THgCiCBX_5MjtSzcg@mail.gmail.com>
In-Reply-To: <CAL4Wiiob6K=Y1ne0G+8L6b8fxNxdCz3z+THgCiCBX_5MjtSzcg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Nov 2026 15:14:48 -0500
X-Gm-Features: AclHuK-R76EHDsnszW-O6Vgi4DzxwqLyNag33759siqThBnXu2JAqQRN94reBA4
Message-ID: <CAHC9VhQGms7L3EL19tB+TRKvNP3ttSumHOdWcNM2377-fQiEOA@mail.gmail.com>
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Jann Horn <jannh@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 6:06=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> w=
rote:
> Le ven. 6 nov. 2026 =C3=A0 22:40, Jann Horn <jannh@google.com> a =C3=A9cr=
it :
> >
> > cipso_v4_delopt() operates on the ip_options_rcu of a socket or a reque=
st
> > socket, and tries to remove CIPSO options from the middle by moving all
> > subsequent options.
> > That's not allowed - ip_options_rcu can be read locklessly and must alw=
ays
> > be consistent. For example, ip_options_undo() reads trusted offsets and
> > length values from the options buffer.
> > Fix it by doing the modification in a copy.
> >
> > The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
> > propagate memory allocation failures.
> >
> > Triggering this bug requires that the system is configured to use CIPSO=
.
> > (Setting up CIPSO requires privileges in init_user_ns.)
> >
> > Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > I've sent a separate mail with a reproducer to Paul Moore.
>
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
>
> Side note, not for this patch: Smack calls netlbl_sock_delattr()
> and netlbl_sock_setattr() under bh_lock_sock_nested() only, which does
> not exclude a concurrent lock_sock() owner such as
> setsockopt(IP_OPTIONS). Both sides can then kfree_rcu() the same
> old inet_opt. This already exists in the "cipso only" branch of
> cipso_v4_delopt() and in cipso_v4_sock_setattr(), and with this patch
> the copy branch has the same issue.
>
> The rcu_dereference_protected(*opt_ptr, 1) in cipso_v4_delopt() hides
> this from lockdep. Smack should probably use lock_sock() like
> SELinux does in selinux_netlbl_socket_connect().

Casey?

--=20
paul-moore.com
