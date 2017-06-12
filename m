From: matt@nmatt.com (Matt Brown)
Date: Sun, 11 Jun 2017 20:34:54 -0400
Subject: [PATCH v1] shebang: restrict python interactive prompt/interpreter
In-Reply-To: <201706101427.EEG90168.OtFFHSFMOVOJQL@I-love.SAKURA.ne.jp>
References: <201706100041.GFH78616.OFtOHFJSLQOMVF@I-love.SAKURA.ne.jp>
	<754b78d1-f7f9-58bd-bf74-fea9e105649a@nmatt.com>
	<20170609164315.GA1141@meriadoc.perfinion.com>
	<d84aaf19-307b-4b60-df74-4fb43a218c9c@nmatt.com>
	<CAGXu5jJt5MRU3ZdKABEbLt4qe-cCLxEm5tMH9SdUh=rtdLUV1w@mail.gmail.com>
	<201706101427.EEG90168.OtFFHSFMOVOJQL@I-love.SAKURA.ne.jp>
Message-ID: <4f8bca84-1798-c92e-f990-77361ac0f605@nmatt.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 06/10/2017 01:27 AM, Tetsuo Handa wrote:
> Kees Cook wrote:
>> On Fri, Jun 9, 2017 at 10:23 AM, Matt Brown <matt@nmatt.com> wrote:
>>> what does everyone thing about a envp_blacklist option that is a list of
>>> environmental variables that will be stripped from exec calls. This can
>>> be done in the LSM hook bprm_check_security.
>>>
>>> Is there any reason on a hardened system why you would need the
>>> PYTHONINSPECT environmental variable?
>>
>> As part of shebang, it likely makes sense to whitelist (rather than
>> blacklist) the env of the restricted interpreters. Though this is
>> starting to get complex. :P
>
> Blacklisting environment variables is dangerous. I think that
> administrators can afford whitelisting environment variable names.
> I think that implementing whitelist of environment variable names
> as an independent LSM module would be fine.

How is blacklisting environmental variables more dangerous than
whitelisting? I'm just suggesting the blacklist be used for the
environmental vars used to bypass the interpreter protections. I don't
think we need a full blown LSM for that.

>
> While it is true that things starts getting complex if we check environment
> variables, shebang will already become complex if it starts worrying about
> updating inode number list in order to close the race window between doing
> creat()+write()+close()+chmod()+rename() by the package manager and teaching
> the kernel the new inode number determined by creat(). We will need an
> interface for allowing the package manager to teach the kernel the new inode
> number and modification of the package manager, for the kernel side is doing
> inode number based blacklisting while user side can execute it before rename().
>

Isn't there a way to take a reference to the inode to prevent the race
condition? I was thinking that a sysfs file could be written to to
update the list of interpreter paths.

Matt
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
