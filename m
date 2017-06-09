From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Sat, 10 Jun 2017 08:04:32 +0900
Subject: [PATCH v1] shebang: restrict python interactive prompt/interpreter
In-Reply-To: <d84aaf19-307b-4b60-df74-4fb43a218c9c@nmatt.com>
References: <bf9f44f5-7b9c-dff1-10e0-84c866c3a372@nmatt.com>
	<201706100041.GFH78616.OFtOHFJSLQOMVF@I-love.SAKURA.ne.jp>
	<754b78d1-f7f9-58bd-bf74-fea9e105649a@nmatt.com>
	<20170609164315.GA1141@meriadoc.perfinion.com>
	<d84aaf19-307b-4b60-df74-4fb43a218c9c@nmatt.com>
Message-ID: <201706100804.FDC30763.tFVOMOLFOFSQHJ@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Matt Brown wrote:
> what does everyone thing about a envp_blacklist option that is a list of
> environmental variables that will be stripped from exec calls. This can
> be done in the LSM hook bprm_check_security.

Stripping argv[0] can be done by remove_arg_zero(). But stripping specific
environmental variables is a bit complicated than what you would think. You
can see tomoyo_environ() for how to whitelist environmental variable names.

> 
> Is there any reason on a hardened system why you would need the
> PYTHONINSPECT environmental variable?

TOMOYO and CaitSith try to check such factors (e.g. argv/envp as well as
pathname manipulations).
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
