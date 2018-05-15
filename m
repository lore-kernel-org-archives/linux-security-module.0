From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 15 May 2018 10:52:28 -0400
Subject: [PATCH v2 11/11] docs: fix broken references with multiple hints
In-Reply-To: <63a4f8a93f9115475bc184d0f37d076c9b9c75ff.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
	<63a4f8a93f9115475bc184d0f37d076c9b9c75ff.1525870886.git.mchehab+samsung@kernel.org>
Message-ID: <20180515105228.4ac2df94@gandalf.local.home>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed,  9 May 2018 10:18:54 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:


> diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> index 7b6b1236ec2e..c292117b83a9 100644
> --- a/Documentation/trace/events.rst
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
> index b0c9c21f129d..716326b9f152 100644
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

> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index c94f466d57ef..19a690b559ca 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -4,7 +4,7 @@
>  /*
>   * Kernel Tracepoint API.
>   *
> - * See Documentation/trace/tracepoints.txt.
> + * See Documentation/trace/tracepoints.rst.
>   *
>   * Copyright (C) 2008-2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
