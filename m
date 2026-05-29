Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36C238D41F
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077810; cv=none; b=DEe+yVv2/gG+3y7RHkh+AVVy3s/xVnjEvsb5uCnzQU8l+KBp6vN/WD78nVtD8kHlhZTbMGDW0o5VsJFD6RjHrihh2REwzq2MM1h6xgGCmhxlhGtJxkK28eoScGUwgqfCqTMl6mwC+4rJQS6XIvJYZy6y7FrfIBTdFor3fhV/Zos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077810; c=relaxed/simple;
	bh=bdER1hojpI6sMD5huzHAOR8Fo/g5r29ArX/EIclxQ2c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s9qKWItZRZO3T8kYOcaR/WL6UWy68igIOYDRFNuJS/aQWg1FYIMT0p/PfmnZC+zXdIoaBGNNY0sFCdgYYNRTSjYZkpEaVJZzcHEJxLK15Rd4T+AO5vBgxQiXVl1D5yhgbrs4OI3sXEFFL2b9nTDkF9wIA5MNDzskYWmh4VMf64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TfSmHag7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TfSmHag7"
Received: from narnia (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id CB00820B7166;
	Fri, 29 May 2026 11:03:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB00820B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780077797;
	bh=ZnI1M++NB8RnowqBOOka4UTpbQ89Hneeo3kZTGt0hZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TfSmHag7SpTuYG34n1lQtSIRzxpdQKBYVhyjxyZDiKofdQzjMhHY9zTDc3vbhSdlP
	 kq/eIcfhOvmyLRghbSpNXsYXZVrZDNqtQszTNudLMidHp6/w1IrfFgm//3O/nakTPL
	 p20M4i3R2s3uPQSF3+GCFWQvqZ6n/zb9hs/TKVYE=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, Fan Wu
 <wufan@kernel.org>, James.Bottomley@hansenpartnership.com,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH 05/11] hornet: gen_sig: fix off-by-one check for used maps
In-Reply-To: <CAHC9VhR6G5qmd3kXPas_L_SiJx=6J=wUw80xxL9Eu4=tSjMAoQ@mail.gmail.com>
References: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
 <20260528030915.2654994-6-bboscaccy@linux.microsoft.com>
 <CAHC9VhR6G5qmd3kXPas_L_SiJx=6J=wUw80xxL9Eu4=tSjMAoQ@mail.gmail.com>
Date: Fri, 29 May 2026 11:03:27 -0700
Message-ID: <87tsrqxfdc.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul Moore <paul@paul-moore.com> writes:

> On Wed, May 27, 2026 at 11:09=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>> A logic bug limited the maximum number of used maps to
>> MAX_USED_MAPS-1.
>
> Should this be MAX_HASHES-1 and not MAX_USED_MAPS-1?
>

Good eye. Yes that should be MAX_HASHES-1 in the commit message.

>> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> ---
>>  scripts/hornet/gen_sig.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/hornet/gen_sig.c b/scripts/hornet/gen_sig.c
>> index b4f983ab24bcd..4e8caad22f381 100644
>> --- a/scripts/hornet/gen_sig.c
>> +++ b/scripts/hornet/gen_sig.c
>> @@ -317,11 +317,11 @@ int main(int argc, char **argv)
>>                         data_path =3D optarg;
>>                         break;
>>                 case 'A':
>> -                       hashes[hash_count].file =3D optarg;
>> -                       if (++hash_count >=3D MAX_HASHES) {
>> +                       if (hash_count >=3D MAX_HASHES) {
>>                                 usage(argv[0]);
>>                                 return EXIT_FAILURE;
>>                         }
>> +                       hashes[hash_count++].file =3D optarg;
>>                         break;
>>                 default:
>>                         usage(argv[0]);
>> --
>> 2.53.0
>
> --=20
> paul-moore.com
