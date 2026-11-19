Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120674;
	b=h7XY0RQKV5xIbKDvdtoQeQxfv5xUaJYaVDhGttnWxTPfqZD9SzQn2NsgDTtyqFqBys1x
	 evk5w5AzVaoM6oDxWaMOxIvZE05M0Y/roJCv6A5SxoveovbKWAjif2mCHt0070Ch0I+ts
	 qN2zvZ7A+B7gNmT8Uqot+63odfWX5ee+5+WWbkbd4gfAe7KLeoWk8wwfE6QsaX7FfUWj8
	 hCevhFZkbT5n6GGbW6YIWHyMI/Fk23dWC3B1zDm7zVOuDHbcCEM8+GYELTeMWBZOjRpA6
	 +cUvbBDTyNyLGhZak+z20queD/r7E5wqWhDQNx6Optx8PbWGTB4ZEKwZv5zxTdqj8tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kEr31tcU68rglk/Zx5XyW3VAn0sFu+PMGSjGQk9S0TY=;
	b=dqJrF8Birc2gGq7lI0Nf59y/5HIhz9Z1++GBDsevIqQA3BdEZjqOq6flVn//m3KCI/yQ
	 I8hFaO6m/WKHapT0F6DGOXkOHkgQYKQsN3Eex4f6NFNnaG5hKMlCIi/WnPXIQCfM8cL2H
	 9bHSayGT0DYWdwDuhpzl2Jv603PXtfufi+koUkcWsSUu2FqfJFoHVm58+OYNgli0QoTob
	 hJUqDjb69Y0VrMJP61ADkQSrQlXkulViQXTk3v1ygvlmgQ5HTKAGlNrbEyVLFyM9afC8s
	 RIL41d/gvO8SBncWaomoV0LbRPkbbNZh3DGQgbaiezH3J+h5OdKnstyoKCQTlAB5Whw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xata.io;
	spf=pass smtp.mailfrom=xata.io;
	dkim=pass header.d=xata.io header.i=@xata.io header.a=rsa-sha256 header.s=google header.b="l/4cSUFN";
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6984A6074327
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 20:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6984A6074327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xata.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xata.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xata.io header.i=@xata.io header.a=rsa-sha256 header.s=google header.b=l/4cSUFN
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-943e8d35f74so22280485a.0
        for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 12:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xata.io; s=google; t=1795120673; x=1795725473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kEr31tcU68rglk/Zx5XyW3VAn0sFu+PMGSjGQk9S0TY=;
        b=l/4cSUFNleEq/Pc4NWDQbAUeSb/CBsRE0rCF48q/L0L4dSrgAJ863g/EZ3eQd6PcBQ
         2izhajQsap0TKPh5306sdd09yrcodVc0q8uuiBRrgUUM5dZ/yDC3yMCZxfx2s8S++vyV
         JSL2LPxwe8MjwMXVIgECs3ZDhsGY0IY0bJlCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795120673; x=1795725473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kEr31tcU68rglk/Zx5XyW3VAn0sFu+PMGSjGQk9S0TY=;
        b=QhY0OIhmwuHchA/Cc2Fm5L/XLkd4tl0JZJRr6meg7AjnwgqTHRSkRa7cXsHW9b7kcr
         keKXCsh7KzTGSRyNBVhjYAcURfk7JzH//YRCeBFnLyoZMQ/aytZoSUVGyy/mQOkOz/Lm
         noMRa6Ot/1hjIVH5v7/+JBsth7CiBQ67ImCK8Wh5a83mCvmbCxDI6YnCSP1+WAR0rIge
         ZpalBIvAgPlE6V0Mr8R/SimLbqZ6YatVwrvENrbPS+UqmS72bt2rXcIxwHSuwNU1xZXo
         XRpBgDHlH/lSTyOX0yqyFW2xkimb1F0iUa8cnm30UAaEY1YM3uy8Etb8XpNL1EEGpYX8
         MEZQ==
X-Forwarded-Encrypted: i=1; AL+hErEza5gSLYx4FiluGanp26yhRfmBHzudAaCwcr4VlxhUHAxyIiiu13W5Jm/gl48to2zoAF+TQbpA3wEmW2bqMm+LJkocp0E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ld6upFpzFz5B0IJ5e+kd8nFBbwKbXeTe7eB71TDQvb1ETCwcF
	avnj8bCw5FEqh5+EecIpWrrVttLNYmo2Dx+6QMVaR07UjYyKeDzVrC+izLi96odjBCWjT05rlbm
	uYVJ169dFcg==
X-Gm-Gg: AYBFou3wZD5txAArQs5gTmyiGpMrqHLhRw/yjfNbsQVMyA9bbLZLMWTeD+AQVfm8DbJ
	FED8zhUciH8BfV4rG87qoJU6EIZKHfUqedr89HmSLHuxFz+FNm3p5gd9BcN1rY5zZmUDg/k5xdp
	VIBkT1diFBxFnJIULcfVULk/ZDpcAjbHaa67fRqNI+M8unekT9fugiqGI2NWCq/9OqRjrQG53Ze
	LuFt4P+5/Nx7b4XDyDdQXnjy/onudUl2Px5uUVPvYIhLYjO9TuJMZBSKakpX2JKzQ6TFgvxD6hW
	NOxY8h2guKQwBXYb+UH2roXGTmyFdYkJP/TPXA8W8dcfarMsDwgvflhLOOE7fJIEJlYX2tqm0D8
	x9aOIJWADtdsMhTlp9J6e3RgwNJEkWYaJZbvSUIDseJH4WWspWNasOZq3YyJPUHCo6uW1nYBpsl
	zkOjbiiQSFOAWuflLptIyL9ZUu+frEJy7Q9PvSECwgZ3X3PC3v5B0PTIu4+4IKbqZH5JSdEy5yU
	UEdHoLIy+IXq4ctZeuZDR8dD4sU9REmtRx3Q74AKH+WZPrtmYj7Davs59myKF910+n7Re7ueTtx
	cxlvqVcsjClNqpgWeA0m6f7+8SiB9hjj/a716oM20/m+fKiFASu+oOUVf00i33hg0Oy4ldwku1O
	JeqtMj0zbqy0uvIGLMBNZDOuk7KL+LlXBK2AVSRkMHGJm3niiz7Qbq7E=
X-Received: by 2002:a05:620a:4724:b0:949:5e26:e92d with SMTP id af79cd13be357-949ba99cc02mr151492585a.31.1795120673241;
        Thu, 19 Nov 2026 12:37:53 -0800 (PST)
Received: from mac-m4-dongle.data.va.local.crowbird.com (pool-173-66-54-232.washdc.fios.verizon.net. [173.66.54.232])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f7cf3sm41035685a.31.2026.11.19.12.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 12:37:52 -0800 (PST)
From: Andrew Kroh <andrew.kroh@xata.io>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: fix label replacement compiled out of __label_insert()
Date: Thu, 19 Nov 2026 15:36:50 -0500
Message-ID: <20261119203650.51147-1-andrew.kroh@xata.io>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__label_insert() replaces an equal label in the labelset from inside
an assertion.

	AA_BUG(!__label_replace(this, label));

AA_BUG() evaluates its argument only if
CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS is set. That option depends on
CONFIG_SECURITY_APPARMOR_DEBUG, which is off by default. Without it,
the compiler discards the call to __label_replace(). The new label
does not go into the tree and does not get FLAG_IN_TREE. The caller,
__label_update(), then removes the old label from the tree.

The proxy of the old label points to the new label. A task that
holds the old label therefore moves to the new label after the first
profile replacement. The new label is not in the labelset, so
__labelset_update() cannot find it on later replacements. A task
with a compound (stacked) label keeps the profile versions from the
first replacement and ignores each later replacement until it execs.

Containers that set no_new_privs and change confinement with a stack
transition show the problem. To reproduce it, load two profiles.

  profile a { ... /usr/bin/bash Px -> a//&b, }
  profile b { ... }

Start a long-lived bash under a//&b. Replace b with a version that
denies a file, then with a version that allows the file again. The
task continues to get the deny. A task under a plain profile follows
every replacement.

Call __label_replace() outside the assertion and assert on its
result.

Fixes: f1bd904175e8 ("apparmor: add the base fns() for domain labels")
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Kroh <andrew.kroh@xata.io>
---
Reproduced on Ubuntu 6.8.0-149-generic, 7.0.0-43-generic and on
apparmor-next (7.4-rc1) on arm64. These steps show the bug (as root):

  echo 'profile a { file, capability, } profile b { file, capability, }' > /tmp/allow
  echo 'profile a { file, capability, } profile b { file, capability, deny /etc/hostname r, }' > /tmp/deny
  apparmor_parser -r /tmp/allow   # load a and b
  aa-exec -p 'a//&b' -- bash      # shell confined by the stack a//&b
  read x < /etc/hostname          # allowed
  apparmor_parser -r /tmp/deny    # replace b: deny /etc/hostname
  read x < /etc/hostname          # denied
  apparmor_parser -r /tmp/allow   # replace b: allow it again
  read x < /etc/hostname          # still denied; allowed with this patch

The check must come from the long-lived task itself. A new exec
(e.g. cat) gets a freshly built label and is not affected.

No other AA_BUG() in security/apparmor has a side effect in its
argument.

 security/apparmor/label.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index fd67262330f9..0dc18743b04a 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -693,6 +693,8 @@ static struct aa_label *__label_insert(struct aa_labelset *ls,
 
 		parent = *new;
 		if (result == 0) {
+			bool replaced;
+
 			/* !__aa_get_label means queued for destruction,
 			 * so replace in place, however the label has
 			 * died before the replacement so do not share
@@ -703,7 +705,8 @@ static struct aa_label *__label_insert(struct aa_labelset *ls,
 					return this;
 			} else
 				__proxy_share(this, label);
-			AA_BUG(!__label_replace(this, label));
+			replaced = __label_replace(this, label);
+			AA_BUG(!replaced);
 			return aa_get_label(label);
 		} else if (result < 0)
 			new = &((*new)->rb_left);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

