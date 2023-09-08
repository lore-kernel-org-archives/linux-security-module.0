Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F013CEEB563
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Sep 2023 17:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241446AbjIHR3h (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 Sep 2023 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjIHR3g (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Sep 2023 13:29:36 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57D41FC9
        for <linux-security-module@vger.kernel.org>; Fri,  8 Sep 2023 10:29:30 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58d9ba95c78so23138487b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 08 Sep 2023 10:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694194170; x=1694798970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhQzRaDL6HOR4JT2yCCXPPaUsvBQgifdAFJ1r1P65GI=;
        b=ZO57+kj6sOrcmzOihJnXXy5IqRuD9xcptK1NgWZin3rvdWmQHy+CHVKzKrUYsSAbMO
         dFLejLBRZ/Hu++yVc+FS9BN9quDCmR+DNQVHN5LtsSnIA9EVIxVxJjoUjSqijVZ+Drpp
         k6W7XUf/6U7+WstrynazC2aa9GUyIMIsAqxXAUF/PW346FsIz1SAUkCXYjcXbYnbyC6O
         6SdWTS8jWSw8YQDpB0PKY3WbyxevnHLlkQcSRGdnRkQT3lslpzihfvwVdRfrsUI63KVv
         xWR9R9RM298g7al+eyg8rUo8S6jH5z/5LPNaS0QLLZrWSOtnA5RQCSCYrmDjUr2gUcnv
         GTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694194170; x=1694798970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhQzRaDL6HOR4JT2yCCXPPaUsvBQgifdAFJ1r1P65GI=;
        b=pseSk2M8a07nXdQTuQAQ4llQFaLrs9lMzQIMfuWV+D+lW2hGsAEY5cP8PYtzyL41h1
         yGhNOXYO2aHIeiNxp1BWx+ikfiQ3Ezdl9+M/2XXodAJy5C8WTTlO6S6LMosHdYVHF38I
         1J/sFuC28wMwJb/GZ337VaGZu9XL7JMKi9bs9dTF+aHitIJuZzY5uZQD0noouCLlt7Au
         pl8XCa28dU/eM6J67it4LkkCIWEX7U+YTYSoA3Mr8EFIBL6RrChvEOHCGaezqIEx+78V
         eltJ+Aw5qnc9Zm3EU+MCU3tmR9xbPmGQt+zsY3brXAk+Uo+eaTxzS5B1Vd7trM05Vl8K
         aaFw==
X-Gm-Message-State: AOJu0YxFs1/+ZKFHhbs9EauHMPg21QmRdx2kEmT5nrmX2SVJirVfFzvz
        3QSh1yA3O+qZSzmuePjccRp2oELcGInLVLqAVjNY7GVJ9iMU7s0QDw==
X-Google-Smtp-Source: AGHT+IEdclROLUnnU8u2QytDCccgtuGIBeWwWqLLRuflphF5oaP/Bntd4ZGhM5o8EawcS3KUffc/1k30gr+mRh/TtNY=
X-Received: by 2002:a81:9250:0:b0:58c:54f8:bd45 with SMTP id
 j77-20020a819250000000b0058c54f8bd45mr3200852ywg.44.1694194169832; Fri, 08
 Sep 2023 10:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com> <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
 <CAHC9VhSw6B5D9ru8trwcejAt_MQKN4g6R0zeTqO_BKRL06km7Q@mail.gmail.com>
 <CAHC9VhQgZ6kRQA7M8BG1H4gW=dPBhPqc5qV72EQqrSt9p0Uhkg@mail.gmail.com> <847729f6-99a6-168e-92a6-b1cff1e6b97f@schaufler-ca.com>
In-Reply-To: <847729f6-99a6-168e-92a6-b1cff1e6b97f@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 8 Sep 2023 13:29:18 -0400
Message-ID: <CAHC9VhQmOqmGHYj9SLS4_qerC-_RB3R6Zvt=NHWyUzLX+KUqiQ@mail.gmail.com>
Subject: Re: ANN: new LSM guidelines
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 8, 2023 at 12:03=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 9/7/2023 3:12 PM, Paul Moore wrote:
> > On Thu, Aug 3, 2023 at 5:38=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >> On Wed, Aug 2, 2023 at 6:00=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >>> On Tue, Aug 1, 2023 at 6:47=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>>> I've updated the README.md doc based on the feedback, and copied the
> >>>> two new sections below for easier review.  If anyone has any
> >>>> additional feedback or concerns, please let me know.
> >>> Another update based on feedback received (thanks everyone!).  Just a=
s
> >>> before, I welcome any comments or feedback you are able to share.
> >> MOAR UPDATES!
> >>
> >> ## New LSM Hook Guidelines
> > ..
> >
> >> ## New LSM Guidelines
> >>
> >> Historically we have had few requirements around new LSM additions, wi=
th
> >> Arjan van de Ven being the first to describe a basic protocol for acce=
pting new
> >> LSMs into the Linux kernel[^1].  In an attempt to document Arjan's bas=
ic ideas
> >> and update them for modern Linux kernel development, here are a list o=
f
> >> requirements for new LSM submissions:
> >>
> >> * The new LSM's author(s) must commit to maintain and support the new =
LSM for
> >> an extended period of time.  While the authors may be currently employ=
ed to
> >> develop and support the LSM, there is an expectation upstream that sup=
port will
> >> continue beyond the author's employment with the original company, or =
the
> >> company's backing of the LSM.
> > Based on some off-list discussions, I've added some text to the end of
> > the paragraph above to allow for a reasonable plan of succession in
> > cases where the original LSM authors are not able to commit to long
> > term support.  Just as before, comments are always welcome :)
> >
> > Here is the new paragraph:
> >
> > "The new LSM's author(s) must commit to maintain and support the new LS=
M for
> > an extended period of time.  While the authors may be currently employe=
d to
> > develop and support the LSM, there is an expectation upstream that supp=
ort will
> > continue beyond the authors' employment with the original company, or t=
he
> > company's backing of the LSM.  If the authors are not able to commit to
> > supporting the LSM for an extended period of time, a reasonable success=
ion plan
> > must be submitted along with the LSM."
>
> This makes it sound like LSMs are always developed for corporate use.

I'll agree that I could probably phrase the paragraph above s little
better, but I disagree with the assertion that the paragraph implies
"LSMs are always developed for corporate use".

How about the following:

"The new LSM's author(s) must commit to maintain and support the new LSM fo=
r
an extended period of time; this applies both to authors that are employed =
to
develop and maintain a LSM as well as those that develop and maintain a LSM=
 on
their own time.  If the authors are currently supporting a LSM as part of t=
heir
employment, there is an expectation upstream that support will continue bey=
ond
the authors' tenure at their current company.  In either case, if the autho=
rs
are unable to commit to supporting the LSM for an extended period of time, =
a
reasonable succession plan must be submitted along with the LSM."

--=20
paul-moore.com
