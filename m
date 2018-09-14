From: keescook@chromium.org (Kees Cook)
Date: Thu, 13 Sep 2018 17:06:16 -0700
Subject: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
In-Reply-To: <a2ffa6b7-5d05-39a1-11c3-d715566e4d51@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
	<99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
	<CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
	<CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
	<CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
	<CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
	<CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
	<CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
	<CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
	<CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
	<0eb75e66-ed50-4013-6440-38bc2f814c6f@canonical.com>
	<CAGXu5jKZ7rquTux5fS+5tQ==0w_9rDTRaJWS_mS7C+Fy2dXRRQ@mail.gmail.com>
	<a2ffa6b7-5d05-39a1-11c3-d715566e4d51@schaufler-ca.com>
Message-ID: <CAGXu5j+PhwfRCg5PycrE-JReVxKMduGsoXStWZN6PfYB-NB1og@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Sep 13, 2018 at 5:03 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/13/2018 4:51 PM, Kees Cook wrote:
>> So, before we can really make a decision, I think we have to decide:
>> should ordering be arbitrary for even this level of stacking?
>
> Do we have a case where it matters? I know that I could write a
> module that would have issues if one hook got called and another
> didn't because because a precursor module hook failed. I don't
> think that any of the existing modules have this problem.

FWIW, I prefer having explicit ordering that cannot be changed at
runtime. I'm just concerned about painting ourselves (further) into a
corner with security= suddenly gaining ordering semantics, but maybe I
can just ignore this and we can point and laugh at anyone who gets
burned by some future change to making it order-sensitive. :)

-Kees

-- 
Kees Cook
Pixel Security
