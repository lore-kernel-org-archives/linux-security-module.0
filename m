From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 14 Jun 2018 12:27:37 -0400
Subject: [PATCH v3 04/27] docs: fix broken references with multiple hints
In-Reply-To: <8e28c30c9d0ba8c4f37d57adac7e12e18296a385.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
	<8e28c30c9d0ba8c4f37d57adac7e12e18296a385.1528990947.git.mchehab+samsung@kernel.org>
Message-ID: <20180614122737.4044a2b7@gandalf.local.home>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 14 Jun 2018 13:08:49 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> +++ b/Documentation/trace/events.rst
> @@ -8,7 +8,7 @@ Event Tracing
>  1. Introduction
>  ===============
>  
> -Tracepoints (see Documentation/trace/tracepoints.txt) can be used
> +Tracepoints (see Documentation/trace/tracepoints.rst) can be used
>  without creating custom kernel modules to register probe functions
>  using the event tracing infrastructure.
>  
> diff --git a/Documentation/trace/tracepoint-analysis.rst b/Documentation/trace/tracepoint-analysis.rst
> index a4d3ff2e5efb..bef37abf4ad3 100644
> --- a/Documentation/trace/tracepoint-analysis.rst
> +++ b/Documentation/trace/tracepoint-analysis.rst
> @@ -6,7 +6,7 @@ Notes on Analysing Behaviour Using Events and Tracepoints
>  1. Introduction
>  ===============
>  
> -Tracepoints (see Documentation/trace/tracepoints.txt) can be used without
> +Tracepoints (see Documentation/trace/tracepoints.rst) can be used without
>  creating custom kernel modules to register probe functions using the event
>  tracing infrastructure.
>  

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
