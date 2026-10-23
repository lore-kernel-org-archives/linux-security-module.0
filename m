Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760602;
	b=j1uVhTq9a1W2xtPcQSTv8ynD7vzEwdsqKhx+mBarH03aLvcFsVqcUuFtVfl9xTAx4cWM
	 342pzfwVjyPZD08VVZtnWQM3bUSf3oAwCIWpfOpaoQ6po37QXP/AsJU5vSRRCQ/5XtiLY
	 w2KKguXJ00XeyYi3QfgUxjpWweQZCk53ldCPE40KmlVfwJoTjmvZ4dOGk05rPtJNMnrbF
	 u2kfDM0Xi2w+l35zBZVLbeCr0OOccXUqIlriBdTqsADCkK1wUjAjAbbX+ZCB4/TX+Jync
	 x4z1wXSmtmsIyVJSqgXJmvbw+YO+1G0Uyhw9BpbZu0+9si3H1TYDMi7IsV7SL3s5kxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iQzFIinZ0RU6+V0s10kA6laKI1A5m5pCKsbRy5/leiE=;
	b=Exb4KaLGP17Jfp2u+oGuTGkYE1+Amrpjgx50VnCPXa2su5qDEChhdsnrWmfiXb4HSCcg
	 BMW8kSCjM7dlJimp8vYi49EaN3GjRngGNBcCiKPQlRHveoDWy+8+zLelMg9nEk4uRWBWj
	 ZzBaCgUR/s02LPlestqcBR63nuRUvRKbLgGXpeMOlF8vtHeZFKqsibmHrw8lhPOLumVUn
	 4hTTeT8GYofxvz0+cZigLI9kqqc1X6ZBCr1HccndN6irx7I5yoKiQT48WZsNEu1Z0gdHj
	 l2Ox21IWV0pxRnkseBc77aSAKQ1oVCDBAEnfCCXb5qxB4z3u21dtBPhGh0HhWmi4hqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="c5e/xe1a";
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7E6606A31A
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 13:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E7E6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=c5e/xe1a
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-679a2297c55so1106283d50.1
        for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792760600; x=1793365400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iQzFIinZ0RU6+V0s10kA6laKI1A5m5pCKsbRy5/leiE=;
        b=c5e/xe1ayA//chxJDjSnZk3+QvQmbFp4ZfKump2DcOl2+526q3uUP/0XBjg9vJs/ZB
         hvZNSrpF60uLrHMIrKEK4YVObYc05+1VxEd4z6kjrPOBK6dhymX/cf7TYn3gdLoekJgc
         SicqUqKfCLSjkWLxN5WI9qyFS7OyhKi3ZRKF+kopDSTHKPkmP6UkdVh8izt2nhv5bhNm
         0ZgAafvnVyAeW3bdFYysisLaMoDA+AYXcGDFahaIci6PEdY3hE2NFQ647YOVhr3PuBfi
         gHFNGUUR2/JDv6S7DfFfGECDqrfn8riK+INtDJhSjdmzez8WsxkhlusAz5qCLTDcEXEn
         RnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792760600; x=1793365400;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iQzFIinZ0RU6+V0s10kA6laKI1A5m5pCKsbRy5/leiE=;
        b=vFzjEtm2iDdS4BU44LU074r99fFJ10oQFy7md5X1vpERu5odkS98qRtRU+20vLZqEs
         oRyEKairW7m4NUDzQm9kso+/Gtb6P4AjA+J77q2V7SV1p3h4gcF20qfULZmHIR4ZER2+
         aVP604N50D+4yMg1X2/+9xznteX7pTv99PsCpiMh8amOnCFjl19LUTqEC+RHPiZiJil+
         mTfALyQA2zlOeWr5+crhSizr7rAWI6kZ/Fk37tvDxOEQKJKhGf5jJU2RC12lm0aC6kcu
         gMffr+W7RUGX5dWz6rG5un792wY/t1hfNyWrJ5aFt7T3DW5LB+DX3OVK01CAaSJbwgmp
         1Jnw==
X-Forwarded-Encrypted: i=1; AKwUvBwDjfPGq4/cyH4gkwEgXP6DgTQHT27PeShsuYwaQjFE97hjR9McO6L+nXK15mZzihV7OSaGOIdVGwJgbUXAdgUirl4IZ4I=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4qfjrRO2Tn9VLUVYknEaWy7We9V3RLwzFb19463HoxUpoztBx
	YPYTxKO1a7TOnGo8iKBzdVt2ARjd2/zGmPzr4uof1d0xUrzqZNUWnhzldZXA5l+ZTAg3FJwXoiJ
	7/AFx
X-Gm-Gg: AYBFou3v7bVSHIb0xmpXCLN5Eixlp+auYHLyWct8lisxllaPbQSuQPrNrPc1IdP7wqr
	2gRofxL0Pv+d8eEmcdYsFtv56kOnVY/sF1uPRkTUaVWFHQCFWnvG1Zc3xMuaydeokMUSVHcrOAA
	tlPkMqL6psg4vmWBK2N5di4wFFnrbUyfMQCDJV92U2pBLm5NMxHsYJHWqXOwBAQr2E84YvdjptF
	JZHpLJ+zrPgFgcX6z32a/gp4HBTeah4Fu1XbMd7WgR4X/GSVHudDk1rfskIK44c/JUyYXkk4+AI
	Uel58OZilzsv0KPCHhTE2n4x6UVA3foGTTkiOkT0rvhVwSPNjlp8EYUcKnLvz7qK5V8oxA4SGl9
	TddoFSVP4t4kG5vJvNo3KmG2MdRNuyRi6kkkeGA0MTDrygTHy5wTNuZ8QfGBTEgUB4gazGNECeS
	anPA7qJgGMdudOdgZZejpaaZ22ZR/Yy303uAXC3CMs+gVYrAoEPVN5E2bNrCkYKQFzqGrREHdpz
	kjtAyX713Gtp13NYq3AUxXV5nWLIcW42cW2R5ajyNIGSuPDJkUhomC5Fpqq54ZPGTPzDLMXLlxg
	FNVFnYli0LhtEktDwQ==
X-Received: by 2002:a53:ac9a:0:b0:679:c86f:cf6b with SMTP id 956f58d0204a3-67a35bb607emr1600926d50.72.1792760599602;
        Fri, 23 Oct 2026 06:03:19 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a3402fc9esm1223884d50.16.2026.10.23.06.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:03:18 -0700 (PDT)
Date: Fri, 23 Oct 2026 13:03:07 +0000
From: Josef Bacik <josef@toxicpanda.com>
To: "Serge Hallyn (AMD)" <sergeh@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 01/13] cred: gather the rules for acting on a task by uid
Message-ID: <20261023-cred-ids-reply-serge-5b0e9c47d21a@toxicpanda.com>
In-Reply-To: <attYWxUJXfZX0MyN@shallyn-amd>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
 <20261018-b4-cred-ids-v1-1-7bdf2db4ea9f@toxicpanda.com>
 <attYWxUJXfZX0MyN@shallyn-amd>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, Oct 23, 2026 at 07:51:39AM -0500, Serge Hallyn (AMD) wrote:
> Overall I like this, thanks.

Thanks for taking a look.

> > +	default:
> > +		return false;
>
> What do you think about putting a BUG HERE?  It's not actually
> your intent for this ever to be called with 'which' not being
> a valid value, right?

Right, that's never supposed to happen, the callers all pass one of the
three by name. I'd rather not BUG() though. It fails closed as it is, so
the worst a bogus value does is get somebody an EPERM, which isn't worth
taking the box down for.

I agree it shouldn't be silent. I think VFS_WARN_ON_ONCE() fits, it's a
WARN_ON_ONCE() with CONFIG_DEBUG_VFS and compiles away to nothing
without it, so whoever adds a fourth value and forgets the switch hears
about it in testing and nobody else pays for it. It's in use outside of
fs/ already, kernel/nstree.c and kernel/nscommon.c have it.

Christian, if that's fine with you could you fold the below into patch
1? Nothing later in the series touches kernel/cred.c so it shouldn't
conflict with anything. Or I can send a v2, whichever is easier. Thanks,

Josef

diff --git a/kernel/cred.c b/kernel/cred.c
index c067ef72b563..9a3ea6a1b96a 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -19,6 +19,7 @@
 #include <linux/binfmts.h>
 #include <linux/cn_proc.h>
 #include <linux/uidgid.h>
+#include <linux/vfsdebug.h>
 
 #if 0
 #define kdebug(FMT, ...)						\
@@ -692,6 +693,7 @@ bool cred_ids_allow_control(const struct cred *subj, enum cred_ids which,
 		gid = subj->fsgid;
 		break;
 	default:
+		VFS_WARN_ON_ONCE(1);
 		return false;
 	}
 
