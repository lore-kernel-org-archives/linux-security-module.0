Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41D87E583
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116280; cv=none; b=VYeA5aoIOexq4noBEN2ZGkA0+TgGS7ussBmf3/FhR/G6miU6HUijOLH76pki54+pp0COOMAnvW2F04lAfbYlP4/2ZhtkWXIojysn9GeaxLtiP366tOkNh0DOQZU+raAjWHI0H338UNMbrBnnrq+9GtDAOaSScaruVjqVYXXcz6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116280; c=relaxed/simple;
	bh=Kl/HAVfdMhADs0Tsv5S4YUd1uTXeFaa2nCYlPTrHhvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIvyXNTTWshZPZOuy7REdoa0eKlzaZn7dh3WzRN9EEdcvyjDDACC0WOPxFQGWQUSX5yhlkNCLcm36cMH0o5F7fQTEbv4izanOzJUdb+/Tj14IEOA2wnL96JFtmIHklZFth1RCpv7dA9uBUwOmPaIA7Y5++3CKTM94JPpi5Z1BE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JNcinWZC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JNcinWZC"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3129939d67so74973366b.2
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 09:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706116277; x=1706721077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9RzKprHyYfiPaLEeOIvMtbDAp0S6N60JXbJyiLEkNDw=;
        b=JNcinWZCDRQmg0eD0Wsa2vTLfEUk5U5b0m8rGQ/dFnAd8k1f77zKjx1BCz3jsOrRE6
         IS1EwfIK2aFhce3YxMMy3mztI8kcCF+GJIrcLDU2XB0n2iWjStO2rfO7XemJmu/MXsQi
         buR04ph/1VVMRmNmO43TH2gHz13ZsCwUMKEbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116277; x=1706721077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RzKprHyYfiPaLEeOIvMtbDAp0S6N60JXbJyiLEkNDw=;
        b=PWycitpLV6g2sIbdIbTrmR3T8GEXydWQGy7b5ntcha+1euKRnBWfZxplG4uXg5XAX1
         cpUT5SF+KWpwhtQ5HC2d9iYDCfFsD/Aw4RxWjRk/6rkvX4MWA7SlA96ubqx90XV8UZzG
         SzeXUMvfYs5/iJuBM/cg88xn0UaJ0qCSc+qz/y3PmAm3oH3LVA7qQ4Pv1QqCY5yPq2Lg
         RqKn593d09Y0qjhnMYdqmaXbcT/iGCFQNwqYqO2kVAoFgyVEFOcnqRpjCj6Vlrh3wn2u
         QcC8sTUxlqs96FBFyVOhwFRIDKbdBJKf6n2UMnj85cpW9mK2AEWMTKJpLvOa+mdWfmWf
         2Trw==
X-Gm-Message-State: AOJu0YyELeZmNFjzysna96StgqT1zK5FLas2p2j1Zy3XnRrOfCSJLWgg
	vqxjoK/0n9nE91PjC5rqhD7wl/mFxwCZpNK/5AQymry+JuOWMkZOd6NsyayUsxI2yMBl8D1FgHI
	YCdKxaA==
X-Google-Smtp-Source: AGHT+IF5o76JS2m8BQxGCiLb6UgYT2HedDealwW6M7zot+LbUmbT17R2yHE6eeG/QJv4mmNnB860WA==
X-Received: by 2002:a17:906:40da:b0:a31:3f4f:bea7 with SMTP id a26-20020a17090640da00b00a313f4fbea7mr445088ejk.39.1706116276738;
        Wed, 24 Jan 2024 09:11:16 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id vu2-20020a170907a64200b00a313ba55c35sm80160ejc.98.2024.01.24.09.11.15
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 09:11:15 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a6833c21eso4396989a12.2
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 09:11:15 -0800 (PST)
X-Received: by 2002:a05:6402:440d:b0:55c:8a2e:df41 with SMTP id
 y13-20020a056402440d00b0055c8a2edf41mr1934309eda.84.1706116275091; Wed, 24
 Jan 2024 09:11:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com> <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
In-Reply-To: <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 09:10:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
Message-ID: <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>
Cc: Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
	Josh Triplett <josh@joshtriplett.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000085dd51060fb42625"

--00000000000085dd51060fb42625
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 08:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. That whole thing is disgusting. I think it should have checked
> FMODE_EXEC, and I have no idea why it doesn't.

Maybe because FMODE_EXEC gets set for uselib() calls too? I dunno. I
think it would be even better if we had the 'intent' flags from
'struct open_flags' available, but they aren't there in the
file_open() security chain.

Anyway, moving current->in_execve earlier looks fairly trivial, but I
worry about the randomness. I'd be *so*( much happier if this crazy
flag went away, and it got changed to look at the open intent instead.

Attached patch is ENTIRELY UNTESTED. And disgusting.

I went back and looked. This whole disgusting thing goes back to 2009
and commit f9ce1f1cda8b ("Add in_execve flag into task_struct").

              Linus

--00000000000085dd51060fb42625
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lrs1gcul0>
X-Attachment-Id: f_lrs1gcul0

IGZzL2V4ZWMuYyB8IDcgKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9leGVjLmMgYi9mcy9leGVjLmMKaW5kZXgg
OGNkZDViMmRkMDljLi5mYzFkNmJlZmU4MzAgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZWMuYworKysgYi9m
cy9leGVjLmMKQEAgLTE4NDMsNyArMTg0Myw2IEBAIHN0YXRpYyBpbnQgYnBybV9leGVjdmUoc3Ry
dWN0IGxpbnV4X2JpbnBybSAqYnBybSkKIAkgKiB3aGVyZSBzZXR1aWQtbmVzcyBpcyBldmFsdWF0
ZWQuCiAJICovCiAJY2hlY2tfdW5zYWZlX2V4ZWMoYnBybSk7Ci0JY3VycmVudC0+aW5fZXhlY3Zl
ID0gMTsKIAlzY2hlZF9tbV9jaWRfYmVmb3JlX2V4ZWN2ZShjdXJyZW50KTsKIAogCXNjaGVkX2V4
ZWMoKTsKQEAgLTE4NjAsNyArMTg1OSw2IEBAIHN0YXRpYyBpbnQgYnBybV9leGVjdmUoc3RydWN0
IGxpbnV4X2JpbnBybSAqYnBybSkKIAlzY2hlZF9tbV9jaWRfYWZ0ZXJfZXhlY3ZlKGN1cnJlbnQp
OwogCS8qIGV4ZWN2ZSBzdWNjZWVkZWQgKi8KIAljdXJyZW50LT5mcy0+aW5fZXhlYyA9IDA7Ci0J
Y3VycmVudC0+aW5fZXhlY3ZlID0gMDsKIAlyc2VxX2V4ZWN2ZShjdXJyZW50KTsKIAl1c2VyX2V2
ZW50c19leGVjdmUoY3VycmVudCk7CiAJYWNjdF91cGRhdGVfaW50ZWdyYWxzKGN1cnJlbnQpOwpA
QCAtMTg3OSw3ICsxODc3LDYgQEAgc3RhdGljIGludCBicHJtX2V4ZWN2ZShzdHJ1Y3QgbGludXhf
YmlucHJtICpicHJtKQogCiAJc2NoZWRfbW1fY2lkX2FmdGVyX2V4ZWN2ZShjdXJyZW50KTsKIAlj
dXJyZW50LT5mcy0+aW5fZXhlYyA9IDA7Ci0JY3VycmVudC0+aW5fZXhlY3ZlID0gMDsKIAogCXJl
dHVybiByZXR2YWw7CiB9CkBAIC0xOTEwLDYgKzE5MDcsNyBAQCBzdGF0aWMgaW50IGRvX2V4ZWN2
ZWF0X2NvbW1vbihpbnQgZmQsIHN0cnVjdCBmaWxlbmFtZSAqZmlsZW5hbWUsCiAJLyogV2UncmUg
YmVsb3cgdGhlIGxpbWl0IChzdGlsbCBvciBhZ2FpbiksIHNvIHdlIGRvbid0IHdhbnQgdG8gbWFr
ZQogCSAqIGZ1cnRoZXIgZXhlY3ZlKCkgY2FsbHMgZmFpbC4gKi8KIAljdXJyZW50LT5mbGFncyAm
PSB+UEZfTlBST0NfRVhDRUVERUQ7CisJY3VycmVudC0+aW5fZXhlY3ZlID0gMTsKIAogCWJwcm0g
PSBhbGxvY19icHJtKGZkLCBmaWxlbmFtZSwgZmxhZ3MpOwogCWlmIChJU19FUlIoYnBybSkpIHsK
QEAgLTE5NjUsNiArMTk2Myw3IEBAIHN0YXRpYyBpbnQgZG9fZXhlY3ZlYXRfY29tbW9uKGludCBm
ZCwgc3RydWN0IGZpbGVuYW1lICpmaWxlbmFtZSwKIAlmcmVlX2Jwcm0oYnBybSk7CiAKIG91dF9y
ZXQ6CisJY3VycmVudC0+aW5fZXhlY3ZlID0gMDsKIAlwdXRuYW1lKGZpbGVuYW1lKTsKIAlyZXR1
cm4gcmV0dmFsOwogfQpAQCAtMTk4NSw2ICsxOTg0LDcgQEAgaW50IGtlcm5lbF9leGVjdmUoY29u
c3QgY2hhciAqa2VybmVsX2ZpbGVuYW1lLAogCWlmIChJU19FUlIoZmlsZW5hbWUpKQogCQlyZXR1
cm4gUFRSX0VSUihmaWxlbmFtZSk7CiAKKwljdXJyZW50LT5pbl9leGVjdmUgPSAxOwogCWJwcm0g
PSBhbGxvY19icHJtKGZkLCBmaWxlbmFtZSwgMCk7CiAJaWYgKElTX0VSUihicHJtKSkgewogCQly
ZXR2YWwgPSBQVFJfRVJSKGJwcm0pOwpAQCAtMjAyNCw2ICsyMDI0LDcgQEAgaW50IGtlcm5lbF9l
eGVjdmUoY29uc3QgY2hhciAqa2VybmVsX2ZpbGVuYW1lLAogb3V0X2ZyZWU6CiAJZnJlZV9icHJt
KGJwcm0pOwogb3V0X3JldDoKKwljdXJyZW50LT5pbl9leGVjdmUgPSAwOwogCXB1dG5hbWUoZmls
ZW5hbWUpOwogCXJldHVybiByZXR2YWw7CiB9Cg==
--00000000000085dd51060fb42625--
