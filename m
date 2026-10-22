Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694205;
	b=0QUMsAy6nZANtCVhL/XA7nEgntIyj5+f4iuWgGGo6ffmgugo+gN9fGG9bJeM6h2LAnaD
	 dggPdPm2dCxOUtrwJVvjAhmP8Vi3IeNhFhigjrWmj70RH0gHZ9LVoyyM06pfIbykXnj1u
	 Ih/jJiYw1l3QtA/eDtFmhFDyJ+fUvbcU7sZ0tfR9aA/nV4Vy94jrpjGvEUNWQ2BlXgH3z
	 cATFFmmXuCIcHo2oR3B8G9ecFxp3Ojhrrh6pbX9+IbVlW7HJqc5vaNmJ7XJxsc6/8ypAk
	 lcKqq3VfhrLaAu57kPNAAb4c9MOJdmoWHmFuPhh9idQgva+yUyrISr/N/8xQEnVtR9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=TljB+llJAtEltt0X5GuRdQ8uO9LKBKu9svl/N9f3acU=;
	b=OdQczuvdrnFS6IZ5knPfKzoJGR95T09ClzRsRwO6MN1u6v2KfFB8VrxcpY2M5WxJl9fe
	 C5qg8osgMk9rw9aEzkhmzuHzF8AISF0oHjt/eLPeCOXD/Q3MPZpPCgCoC0fbBOFBwP/Ur
	 49BPaYWUlMYQBr73RQ6CYgl8qRVTZnClvBjPl4mb+1vU7HLSu5WvepmpJE6oh5WSMqF9h
	 zfaHkIXOtf9yaeDZjo4hPB2TUoGA8+51v8q7TzidhX7DEuQEtnUa/8OXbnzgX8PtGtw7z
	 vW5sjddlsOX8Xq22U93cOAb90u9u5WR3gA1Nc6pOEG5DzwxBtV0d77Q7vBHzqGp4CgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=F7z5QRbE;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720760A3812
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 18:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2720760A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=F7z5QRbE
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-9178d514951so2145006d6.0
        for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 11:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792694204; x=1793299004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TljB+llJAtEltt0X5GuRdQ8uO9LKBKu9svl/N9f3acU=;
        b=F7z5QRbEHW8hNFtC9lVdaa1zTXyrbim1jVDneirl+zVZZRajgDmg3t4LLo6I8nDu8a
         RKIieFupHq+p9BNDrZlca1+DcUMUtlXzaY+uz3/nZCQyn6374BYmXT9UJ7qlIwEokWzF
         DPa0l4+FdMdpqUOlHQNSVyu1bULSLFht9Vp+xtYPi1ZNtqTvHpbwjZENIKQXBkBcy8pA
         FWTf6Z7cIVzuGPE2oatiP1e6+P4evADSipde4L5A/2eRrlYCTSxaQYmn1PyAmC8rrEcq
         Y4dO34r2xxWrgV3C/rruNnuW2dg4UQuMR7qTu/Hs0Bz9hs5NpzYPf8gN4UYgXwEOmWCv
         nPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694204; x=1793299004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TljB+llJAtEltt0X5GuRdQ8uO9LKBKu9svl/N9f3acU=;
        b=d5wMe060c6rwOS0u48tlMcOEO6sXeD5gXwnhhZP+129FZcss2zY2cnQR53yxkjRcfE
         ytHScY99QbLQh4BanZytebZexVHPbjpDvAmJgAgfXmWnzldgvdB0zAh2lUB08hiAlJ6o
         e2O3Z3Ex3+fjHGivqbmKk4RzYefdDMx1GHfYYFftcajrL8IdLDKFNsTdmC0zHSIm5z2Z
         scZYtcwg9b6QmA9qlUZv4aqe6jLlyn122XEDLtk2eCFGPW05fWCzptpX8VoBP01sD+4u
         IghitMNs8aMImCDiIISPonlO+VZlioytSwwrRsViNRy9bCfZjfRmXa0+QA3kpvKF9dyo
         AZkg==
X-Forwarded-Encrypted: i=1; AKwUvBy2gCMT69gqMa/pdRM4gxjvu0i9Kj0fzxFgCoIIEvTgkfQhqu0KjObTvm1/gbeljgDto7ZkICzSVh6wzV2LsP3QYOHFprk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWpdzU7VLgp9FRFa3Rkr/mqdzDdrqzUoqYDoO0rkee2aU+sui1
	EGCMfZ5Wxm/OqltL95d1t/ft2JZl/gFB9kCWHNak4CBA2y5RCiGLaPh6K7K97NWLEFA=
X-Gm-Gg: AYBFou3tp4ViXD62e8YAzlfBJtYHcZjQa1iJrW+T8qq8X/xPwE09NzCbiSQnD5qEkP3
	vjHKtgLlbVIjjyM+B4+DZeMjLGosrZNG6NK/SkS2ZioDl5Km8Pfu6SObrGVe5pcfE9V4HlQYhvc
	lmCeQDo0jKK8B8RLMbROEVcm03KIdSjmxeixBvizJh2KROS/8lFrCOBqU0n1tGLW2S+FcMIQIkl
	MZU5FUD9O1zWWeCXO6Qy+9no8HbW5KvSxcnB/evIT3ZRxjpwwOPH1rwaTGTLxXJI9oPJIL52kBX
	nH+kvLE16c3uKyZ/MXSqk9Sf80VZL6cyGEsdDjmPPedoNVw7hw2Sw+y2zKIDSYW5yn6191XMzg6
	AIRb2Nl366WnGaFhpo0/RLEPolRjzE/QVcO6yFi0nUaHweM0twB3CPojUjeU/0qIUCoeFrSjbmy
	Rd56gmWSDU+jEzZPLiFJOEPs+Z4j9C8r7sl7G5XhvXVIpHI7L8PSkn5HiaiR7gyIcp2trF+/uUh
	m0MmegR08YATeDR3WMC3hrSozbDnzb1cbSLqrslh8qT19VVX4TS5RN48JWnbkHCSM8tu6G5
X-Received: by 2002:a05:620a:2b97:b0:93b:eb9a:ca47 with SMTP id af79cd13be357-93f6f941cb5mr51504685a.31.1792694204079;
        Thu, 22 Oct 2026 11:36:44 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f6fa79976sm20911585a.1.2026.10.22.11.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:36:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 22 Oct 2026 18:36:22 +0000
Subject: [PATCH v4 4/5] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-b4-setfcap-userns-v4-4-88aa0ffaa08f@toxicpanda.com>
References: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
In-Reply-To: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792694192; l=4387;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=aZfwbbad7JbWE1sbfyYkODripimDq3vAr36rblWADSA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QF3MVCsE+gzeGnl2Q+YtC/TsNj0oxCQUnKW3Si0zQrjO0OC244dOuQ90gD49mg97mO9JhJiHqi1
 k3NoNWYpR6As=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
keeps a root process without CAP_SETFCAP from creating a user namespace
that maps uid 0, in which it could attach capabilities to a file that
are then honoured outside.  But the map doesn't have to be written by
that process.  A privileged task can write it from the parent, and the
file capabilities are not checked against the outside at all:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
                                    unshare(CLONE_NEWUSER)
                                      ns->setfcap_level = 1
  write "0 0 1" to B's uid_map, gid_map
    A has CAP_SETFCAP -> allowed
                                    setxattr(file, "security.capability")
                                      rootid = kuid 0
  uid 1000 in the initial namespace:
  execve(file)
    file capabilities apply

The map doesn't even have to show uid 0 of the parent as uid 0, since a
v3 xattr can name any mapped uid as the root user.

Check at the place where it matters, in cap_convert_nscap().  On an
idmapped mount the root user named in the xattr has two identities: the
kuid seen through this mount, and the kuid that is stored and seen
through every other mount of the filesystem.  If either of them is the
root user of an ancestor of the caller's namespace too, CAP_SETFCAP has
to reach up to there, which ns->setfcap_level tells.

A v2 xattr skips the conversion when the writer has CAP_SETFCAP over the
filesystem's namespace, and belongs to that namespace's root user.  It
gets the same check: if that root user is out of reach, the xattr goes
through the conversion instead, and is refused there.  Otherwise a task
that unshared without CAP_SETFCAP could mount a tmpfs in its namespace,
write a v2 xattr on it, and have it honoured through an overlay mounted
from the initial namespace.

Tasks in the initial namespace, tasks in namespaces created by a task
with CAP_SETFCAP, and file capabilities for a root user that only exists
in namespaces within reach are not affected.  That includes everything
an unprivileged user does in its own namespaces.  The rest gets -EPERM.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index b06914223039..655e822c8e76 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -694,19 +694,41 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EINVAL;
 	if (!capable_wrt_inode_uidgid(idmap, inode, CAP_SETFCAP))
 		return -EPERM;
-	if (size == XATTR_CAPS_SZ_2 && (idmap == &nop_mnt_idmap))
-		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
-			/* user is privileged, just write the v2 */
-			return size;
+	/*
+	 * A v2 xattr belongs to the root user of the filesystem's namespace,
+	 * which may be the root user of ancestors of our namespace as well.
+	 * Only write it unconverted if that root user is within reach, the
+	 * checks below handle everything else.
+	 */
+	if (size == XATTR_CAPS_SZ_2 && idmap == &nop_mnt_idmap &&
+	    ns_capable(fs_ns, CAP_SETFCAP) &&
+	    cap_root_level(make_kuid(fs_ns, 0), task_ns) >=
+	    task_ns->setfcap_level)
+		/* user is privileged, just write the v2 */
+		return size;
 
 	vfsrootid = rootid_from_xattr(*ivalue, size, task_ns);
 	if (!vfsuid_valid(vfsrootid))
 		return -EINVAL;
 
+	/*
+	 * The root user may be the root user of ancestors of our namespace as
+	 * well.  CAP_SETFCAP that we got for entering it doesn't cover those.
+	 * On an idmapped mount the root user is vfsrootid as seen through
+	 * this mount and rootid as seen through every other mount of the
+	 * filesystem, so both have to stay within reach.
+	 */
+	if (cap_root_level(vfsuid_into_kuid(vfsrootid), task_ns) <
+	    task_ns->setfcap_level)
+		return -EPERM;
+
 	rootid = from_vfsuid(idmap, fs_ns, vfsrootid);
 	if (!uid_valid(rootid))
 		return -EINVAL;
 
+	if (cap_root_level(rootid, task_ns) < task_ns->setfcap_level)
+		return -EPERM;
+
 	nsrootid = from_kuid(fs_ns, rootid);
 	if (nsrootid == -1)
 		return -EINVAL;

-- 
2.55.0

