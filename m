Received: from mail-lr2-f27.google.com (mail-lr2-f27.google.com [74.125.230.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3AF56260F
	for <linux-security-module@vger.kernel.org>; Tue, 22 Sep 2026 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094499; cv=pass; b=TTtZXEUWDFlM6DW3XEJo1D0syFzAwCEOqJEPgpFUiLIUvyX6Y5+fOwkZ6nJYnXDUWfMx19W2eMoOFel8dwDAhIxt2DJviwlDa/LDXDAlpmtm/QN7qRtkFIHpHZCD7gMDF7nJA+chfkTvIxXiF7eL+xCN9+T91GKjwEuTwoLbecs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094499; c=relaxed/simple;
	bh=g41lSEJVifoLLki8xKaYXd2wESUfC9pFlILsyKjBmxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYF5XNX6BNo/ncy1Qlb9Ic/GBq3hEUVqrLk3cJeRvjuRL8anZq7vUnJZ59bp7opDUyey6UEIvvn9eIESG9cUMn9TM4ZdntQQS9MYrgRhYcHc1qB34xJo1Vjy2TZvouXOucn40AnFlGHSIzbMepcQo0KJhEgRWBX/3cOewjQFscg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qyrzTAks; arc=pass smtp.client-ip=74.125.230.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyrzTAks"
Received: by mail-lr2-f27.google.com with SMTP id 38308e7fff4ca-3a5b6840edcso39175041fa.1
        for <linux-security-module@vger.kernel.org>; Tue, 22 Sep 2026 09:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790094495; cv=none;
        d=google.com; s=arc-20260327;
        b=IztAzF/nuN1idyXiol+hFp4MkLwQpRx+0FByBN1UTdVw6eFYMCqnHFnRQ7EFfDi8dL
         7pjqipUpR3UhHoHLoEp2oSdNV7y8TkjTfRPNFwVHUQL9xKiRUskuhtktqahCNXnj4pgt
         5Ta5aEdzFs7+My+3xIzFTjMUT989ShRL/uOWBB74OhrnGfoX0i+McjgB8NcpOr/k4Hpu
         Yh2MWD2Ani0WnqiPdZcmKSGJZ4npiZwGWaVu8PsrwxU00o3CzHUY7hz2h97IbPYkQC/T
         vZAogRfZIRMXUf7Yde2UPya2CZG1A30rk1+dFI/isNsUcOpS+nFXvkaJZYfVw/KotmqA
         6d6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=a/BHeMU5owW/H6JFz/PFt/fhWxi9JFNw6SR1iQIoH/8=;
        fh=xnTjhrkofOYTfYTpL7VDGSi4wpD1cAbaLd7+sTh+4HY=;
        b=RjfqPZfB6qQN7QxtIFtssv/EOa+Ir451jVWwWbHTNCC/LD8a73ODinTffRNSkMN2Rp
         awLP14+LIx/OA6UcVyC/TaXGJaYCrL5UhaPL1eqhrzucw+Q9ZpEjguvbUWdTdXaRAnAs
         Z5a1XGh/aqmEXyX1o2Ur5/IBNMiZhmLinkVbZ7xIxdQWZnX3+g14yhKXaXFZcgkLBw6U
         9H6C2SF+Ea8rh0/Kp7YuPe+lhKcV68Is9eiNWw9ERsjQ+tSGebjNYqEQC0IchngyX5AG
         uRB9Jo4si0N2/0fH/1fdjM2V3/8Vf4Mnr17EmeRTJPYMSm94r2IFHmTZcnDcKqFH1bb8
         k1xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790094495; x=1790699295; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a/BHeMU5owW/H6JFz/PFt/fhWxi9JFNw6SR1iQIoH/8=;
        b=qyrzTAks1dM4rPBUF+gxjTisJo0cY9jLiPW7MCiPoxPMHg67NsJs1tIC736ZuBpSYL
         hofM3msNBORAN5ybS6ecvZ9x6d4CM9zxiOaHao4GFkY/8o6Aybyq6caOqbWYIjmdPL+A
         wBIBeMoOplpYAQgTHmnOMVn5mW6K+osLEJidHLic9P5fZoSet8xTjHiskZPhEC4nKc7D
         BH2x167UdM37hEOiBKJdp3JC19SYPHtR4uXEsUkSUMPUiaMT4JubrY1ZFcxNKFKWsc7Z
         fStmP/3koB8u62ja3Icbgeff54eeLdal9NPjgCEqMeHLxjzJwRcpMxVWI5kr6hOj9EJf
         kwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790094495; x=1790699295;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a/BHeMU5owW/H6JFz/PFt/fhWxi9JFNw6SR1iQIoH/8=;
        b=NqRpZfZFViLEjtUpX54WcFf4Dz+bRyCaQGePGLJlv4B+ke695C30fcu2S5vyZa7DHU
         DUSQLOAPBv3H7HIIHiuaw/b8q5KsYugHTVjU7jApO8AK86bPQrgGe0XxUcOzojwDl1xd
         fqEBcECd9Y1mx2taScXpdya4k+V0lwFQ6ZiUoTMhtH86u4q/s+nkr+2kxCJsXmS8DHkE
         1h/pUMUKiY9XkjFMRb8cji3LyjHTUtDT4nn8Ey8wJ6lncnnZjz3y6rhB0wDARWD8tpK6
         cVknsdhy1aGYI/1iDXpPK2Jofm9NRoCh0SUXQM/wIxIGm7ugq0it03UOoCiC+CavvwiW
         iz8g==
X-Forwarded-Encrypted: i=1; AKwUvBz9Msi7wtDIsdlu7Llqo9+gcpn3DLA0UV5p6gzKOk1msMfTaE6DNBJ0+ZDOgoUTkDHWvgBR94brXl0mFlnsyMWXsGRjOY0=@vger.kernel.org
X-Gm-Message-State: AFuF++no1F4Gc8w3SWHLdhzGU6Twbu7lSPK8UkoniePzwKAHcr9AYFFY
	OmUDqwPEWIQPBDncuNRvrdSQDHGLr+0AgzHHcO85mymQnW6iEnONoKwlctxMWb1lmfj75fyyoh/
	N2MLWfYoBPyEbEcQ/9TJmJKr7kjfojLk=
X-Gm-Gg: AYBFou3logldtIoyKU6PTwNrsrTN71u0FvIFbUjjNBeiRM3KKyaL+Rt1gKZCFGY//1m
	SWtQ4IKZ5buOVaHxFbGpVYi93t3Lrq3YtR4FRRbcQiRnj/wf4SyNoUMZ6+7Ru9WwYZfOO1rgFEH
	y5bBRiUaVqS+SRkrbkbm3wd91wyRzHoGnsP6aEoRvcatLei+nL/PQhZXIDXczC66Yl7N6QRVuz8
	GvDjEBp1r46UVNuQUGjRvc3xkvYi8dNNoujHn7B/3GEONhRFeOSSamvnDjwTe8q54Pm3PRQCPjo
	czd06ga7hLdwC7SnV3G18+yxgjZPGHxF6+26eC3CnzXI/9hOMgbCYXH8mKbiwpq4Kbxfos9P0HR
	W60FmV3W1ghJFzA==
X-Received: by 2002:a05:651c:30c9:b0:3a5:f982:9c78 with SMTP id
 38308e7fff4ca-3a5fbebfc4emr31286961fa.2.1790094494779; Tue, 22 Sep 2026
 09:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANGjgdnoz4NdqzOV9+SZaYTc+O_GkNNn5NVp+ZpHUQbp5h-QVQ@mail.gmail.com>
 <075aec24-cb7b-44ea-b3d8-be913a87c958@canonical.com>
In-Reply-To: <075aec24-cb7b-44ea-b3d8-be913a87c958@canonical.com>
From: Chengfeng Lin <lin2530632123@gmail.com>
Date: Wed, 23 Sep 2026 00:27:59 +0800
X-Gm-Features: AcwNN1WT15TcNQbGkaUlrPH7CYeriQ9Jzn6FIklMTfXi30WpsDL6oO2ILNL91P0
Message-ID: <CANGjgdmQZ3AdU5Lr-vYYph9iJ_YwFDd5XaeF6XFgOMEEmaL3nQ@mail.gmail.com>
Subject: Re: [REGRESSION] apparmor: AF_UNIX datagram send slowdown after 6456ccbd2ff7
To: John Johansen <john.johansen@canonical.com>
Cc: georgia.garcia@canonical.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: multipart/mixed; boundary="00000000000079fc08065c14da23"

--00000000000079fc08065c14da23
Content-Type: text/plain; charset="UTF-8"

Hi John,

I tested a small early-return prototype on v7.3-rc4 (93f51579e7df).
It reduced send syscall time by 12.84% in the original unconfined
socketpair benchmark. A separate two-process test found a 1.25% cost
when both peers were confined but allowed to communicate.

The attached patch returns early from aa_unix_peer_perm() only when the
whole label is unconfined. It skips peer-address and audit preparation.
The sender and receiver are still checked separately. The patch adds no
per-object fields and does not change label updates or locking.

For each prototype comparison, I used original -> patched -> original,
with a separate boot for each point. Both kernels used the same baseline,
GCC 15.2.0 and config, except for the kernel release suffix
(CONFIG_LOCALVERSION). The machine was the same bare-metal i7-12700KF
with 32 GiB RAM, full preemption, performance governor/EPP and Turbo off.

Each condition had three invocations per boot. Each invocation had
3 warm-up and 15 measured rounds of 65,536 messages, sent in batches of
32 messages of 128 bytes. Only sendmmsg() was timed; peer draining and
payload checks were outside the timed interval.

The original socketpair test ran on CPU 2. Results in ns/message were:

  original A       patched       original B
     416.073       359.448          408.719

The patch saved 52.95 ns/message, or 12.84%, against the original midpoint.
Maximum within-invocation CV was 0.114%; original-kernel drift was 1.78%.

The two-process test used connected abstract AF_UNIX datagram sockets,
with the sender on CPU 2 and receiver on CPU 4. Both ran as UID 1000.
The confined policies allowed communication. Results in ns/message were:

  peers                  original midpoint   patched      change
  both unconfined                  455.564     412.052      -9.55%
  sender confined only             569.902     561.786      -1.42%
  receiver confined only           578.244     562.807      -2.67%
  both confined                    741.385     750.620      +1.25%

The socketpair and two-process tests have different workload shapes.
Their absolute timings should not be compared directly.
The both-confined case added 9.24 ns/message, with maximum CV 0.51%
and original-kernel drift 0.16%. Across all four cases, these maxima
were 1.80% and 0.60%. These are send-only microbenchmark results,
not application timings.

I tested confined/unconfined peer combinations, stacked labels, datagram
and stream sockets, old and new policy ABIs, and serial policy replacement
followed by socket recreation. Allow and deny results matched expectations
on both the original and patched kernels. Fine-grained UNIX permission
tests used ABI 5.0 with network_v9.

Separate untimed probes confirmed that the outer checks still ran for
both sender and receiver. In the unconfined socketpair probe, internal
unix_peer_perm() calls were 2,112 -> 0 -> 2,112 across
original -> patched -> original. The two-process probes also confirmed
that only unconfined sides skipped this internal check.

The follow-up kept sockets open across policy and mode changes. Permission
results matched between the original and patched kernels. Each boot also
had two concurrent tests, each lasting two seconds with 16 policy
replacements during the send loop. A fixed sender deny remained effective
while the receiver policy changed.

One limit is worth noting: receiver-side deny updates did not revoke
access through the existing socket, on either kernel. That path uses the
socket's stored label, so matching the original behavior does not prove
immediate revocation. The live-update tests did not cover stacked labels
and were not exhaustive.

Separately, the original controlled source delta still reproduced a
13.61% slowdown. v7.3-rc4 was 20.35% slower than the same old baseline.
The latter includes other source and config changes; I do not attribute
that whole gap to 6456ccbd2ff7.

Results and test sources are at [1].

Would this whole-label early return be worth pursuing, given the small
cost on the both-confined path? This is a prototype for review.

Thanks,
Chengfeng

[1] https://github.com/lcf0399/linux-regression-evidence/tree/23b61ebab6aff0d8316334da7a988811082d204d/apparmor-af-unix-send-old-abi-6456cc/bare-metal/early-unconfined-20260922

--00000000000079fc08065c14da23
Content-Type: text/plain; charset="US-ASCII"; name="0002-early-unconfined.patch"
Content-Disposition: attachment; filename="0002-early-unconfined.patch"
Content-Transfer-Encoding: base64
Content-ID: <>
X-Attachment-Id: 

LS0tIGEvc2VjdXJpdHkvYXBwYXJtb3IvYWZfdW5peC5jCisrKyBiL3NlY3VyaXR5L2FwcGFybW9y
L2FmX3VuaXguYwpAQCAtNjM0LDEyICs2MzQsMTcgQEAKIAlzdHJ1Y3QgdW5peF9zb2NrICpwZWVy
dSA9IHVuaXhfc2socGVlcl9zayk7CiAJc3RydWN0IHVuaXhfc29jayAqdSA9IHVuaXhfc2soc2sp
OwogCWludCBwbGVuOwotCXN0cnVjdCBzb2NrYWRkcl91biAqcGFkZHIgPSBhYV9zdW5hZGRyKHVu
aXhfc2socGVlcl9zayksICZwbGVuKTsKKwlzdHJ1Y3Qgc29ja2FkZHJfdW4gKnBhZGRyOwogCiAJ
QUFfQlVHKCFsYWJlbCk7CiAJQUFfQlVHKCFzayk7CiAJQUFfQlVHKCFwZWVyX3NrKTsKIAlBQV9C
VUcoIXBlZXJfbGFiZWwpOworCisJaWYgKHVuY29uZmluZWQobGFiZWwpKQorCQlyZXR1cm4gMDsK
KworCXBhZGRyID0gYWFfc3VuYWRkcih1bml4X3NrKHBlZXJfc2spLCAmcGxlbik7CiAKIAlyZXR1
cm4gdW5peF9wZWVyX3Blcm0oc3Vial9jcmVkLCBsYWJlbCwgb3AsIHJlcXVlc3QsIHNrLAogCQkJ
ICAgICAgaXNfdW5peF9mcyhzaykgPyAmdS0+cGF0aCA6IE5VTEwsCkBAIC04MDksNCArODE0LDMg
QEAKIAogCXJldHVybiBlcnJvcjsKIH0KLQo=
--00000000000079fc08065c14da23--
