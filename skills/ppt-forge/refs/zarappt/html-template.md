# ZaraPPT HTML 架构规范

> A 阶段（Slide 批量制作）的执行细节。
> 来源：frontend-slides html-template.md

## 核心原则

**画 HTML 是创作，不是填表。每页 slide 是一个独立的信息设计作品。**

- 目标：让受众看完这页后产生你预设的认知变化
- 手段：混合布局、真实素材、多层级信息架构
- 约束：archetype + viewing mode 决定一切排版参数

## 开工前确认

画之前必须已经有：

| 参数 | 来源 | 示例 |
|------|------|------|
| **输出格式** | 用户选择 | HTML 单文件 / PPTX 单文件 |
| archetype | 用户/内容规划 | 架构总览 / 数据洞察 / 方案对比 |
| viewing mode | 用户确认 | presentation（大屏）/ document（阅读） |
| 品牌 | 主 skill 开局 | ZaraPPT / 华为 / Apple / 通用 |
| 预设 | 用户选择 | Bold Signal / Terminal Green / 等 |
| 本页目的 | 一句话 | "证明对等判断优于中央编排" |
| 证据源 | 明确列出 | `03-architecture.md` + git log |

**没有这 7 项 = 不许动手画。**

---

## Base HTML Structure

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Presentation Title</title>

    <!-- Fonts: MUST use Fontshare or Google Fonts — never system fonts -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=...">

    <style>
        /* ===========================================
           CSS CUSTOM PROPERTIES (THEME)
           Change these to change the whole look
           =========================================== */
        :root {
            /* Colors — from chosen style preset */
            --bg-primary: #0a0f1c;
            --bg-secondary: #111827;
            --text-primary: #ffffff;
            --text-secondary: #9ca3af;
            --accent: #00ffcc;
            --accent-glow: rgba(0, 255, 204, 0.3);

            /* Typography — MUST use clamp() */
            --font-display: 'Clash Display', sans-serif;
            --font-body: 'Satoshi', sans-serif;
            --title-size: clamp(2rem, 6vw, 5rem);
            --subtitle-size: clamp(0.875rem, 2vw, 1.25rem);
            --body-size: clamp(0.75rem, 1.2vw, 1rem);

            /* Spacing — MUST use clamp() */
            --slide-padding: clamp(1.5rem, 4vw, 4rem);
            --content-gap: clamp(1rem, 2vw, 2rem);

            /* Animation */
            --ease-out-expo: cubic-bezier(0.16, 1, 0.3, 1);
            --duration-normal: 0.6s;
        }

        /* ===========================================
           VIEWPORT BASE STYLES (MANDATORY)
           Copy FULL contents of zarappt-viewport.css
           =========================================== */
        html, body {
            height: 100%;
            overflow-x: hidden;
        }

        html {
            scroll-snap-type: y mandatory;
            scroll-behavior: smooth;
        }

        .slide {
            width: 100vw;
            height: 100vh;
            height: 100dvh;
            overflow: hidden;
            scroll-snap-align: start;
            display: flex;
            flex-direction: column;
            position: relative;
        }

        .slide-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            max-height: 100%;
            overflow: hidden;
            padding: var(--slide-padding);
        }

        /* ===========================================
           ANIMATIONS
           Trigger via .visible class (added by JS)
           =========================================== */
        .reveal {
            opacity: 0;
            transform: translateY(30px);
            transition: opacity var(--duration-normal) var(--ease-out-expo),
                        transform var(--duration-normal) var(--ease-out-expo);
        }

        .slide.visible .reveal {
            opacity: 1;
            transform: translateY(0);
        }

        /* Stagger children for sequential reveal */
        .reveal:nth-child(1) { transition-delay: 0.1s; }
        .reveal:nth-child(2) { transition-delay: 0.2s; }
        .reveal:nth-child(3) { transition-delay: 0.3s; }
        .reveal:nth-child(4) { transition-delay: 0.4s; }
        /* ... */

    </style>
</head>
<body>
    <!-- Progress bar -->
    <div class="progress-bar"></div>

    <!-- Navigation dots -->
    <nav class="nav-dots"></nav>

    <!-- Slides -->
    <section class="slide">
        <h1 class="reveal">Title</h1>
        <p class="reveal">Subtitle</p>
    </section>

    <section class="slide">
        <div class="slide-content">
            <h2 class="reveal">Slide Title</h2>
            <p class="reveal">Content...</p>
        </div>
    </section>

    <script>
        /* ===========================================
           SLIDE PRESENTATION CONTROLLER
           =========================================== */
        class SlidePresentation {
            constructor() {
                this.slides = document.querySelectorAll('.slide');
                this.currentSlide = 0;
                this.setupIntersectionObserver();
                this.setupKeyboardNav();
                this.setupTouchNav();
                this.setupProgressBar();
                this.setupNavDots();
            }

            setupIntersectionObserver() {
                const options = {
                    root: null,
                    rootMargin: '0px',
                    threshold: 0.5
                };

                const observer = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            entry.target.classList.add('visible');
                            const index = Array.from(this.slides).indexOf(entry.target);
                            this.currentSlide = index;
                            this.updateProgress();
                            this.updateNavDots();
                        }
                    });
                }, options);

                this.slides.forEach(slide => observer.observe(slide));
            }

            setupKeyboardNav() {
                document.addEventListener('keydown', (e) => {
                    switch(e.key) {
                        case 'ArrowDown':
                        case 'ArrowRight':
                        case ' ':
                        case 'PageDown':
                            e.preventDefault();
                            this.nextSlide();
                            break;
                        case 'ArrowUp':
                        case 'ArrowLeft':
                        case 'PageUp':
                            e.preventDefault();
                            this.prevSlide();
                            break;
                        case 'Home':
                            e.preventDefault();
                            this.goToSlide(0);
                            break;
                        case 'End':
                            e.preventDefault();
                            this.goToSlide(this.totalSlides - 1);
                            break;
                    }
                });
            }

            setupProgressBar() {
                const progressBar = document.getElementById('progressBar');
                window.addEventListener('scroll', () => {
                    const scrollTop = window.scrollY;
                    const docHeight = document.documentElement.scrollHeight - window.innerHeight;
                    const progress = (scrollTop / docHeight) * 100;
                    progressBar.style.width = progress + '%';
                });
            }

            setupNavDots() {
                const navDots = document.getElementById('navDots');
                this.slides.forEach((_, index) => {
                    const dot = document.createElement('div');
                    dot.className = 'nav-dot' + (index === 0 ? ' active' : '');
                    dot.addEventListener('click', () => this.goToSlide(index));
                    navDots.appendChild(dot);
                });
            }

            updateProgress() { /* ... */ }
            updateNavDots() { /* ... */ }
            nextSlide() { /* ... */ }
            prevSlide() { /* ... */ }
            goToSlide(index) { /* ... */ }
        }

        new SlidePresentation();
    </script>
</body>
</html>
```

---

## Required JavaScript Features

Every presentation must include:

### 1. SlidePresentation Class

Main controller with:
- **Keyboard Navigation**: Arrow keys, Space, Page Up/Down, Home, End
- **Touch/Swipe Support**: Touch events for mobile
- **Mouse Wheel Navigation**: Optional scroll-based navigation
- **Progress Bar**: Updates on scroll
- **Navigation Dots**: Click to jump to slide

### 2. Intersection Observer

For scroll-triggered animations:
- Add `.visible` class when slides enter viewport
- Trigger CSS transitions efficiently

### 3. Optional Enhancements (match to chosen style)

- Custom cursor with trail
- Particle system background (canvas)
- Parallax effects
- 3D tilt on hover
- Magnetic buttons
- Counter animations

---

## Inline Editing (Optional)

Only include if user opted in during Phase 1.

### Required approach: JS-based hover with 400ms delay timeout

**Do NOT use CSS `~` sibling selector for hover-based show/hide.** The pointer-events: none on the toggle button breaks the hover chain.

HTML:
```html
<div class="edit-hotzone"></div>
<button class="edit-toggle" id="editToggle" title="Edit mode (E)">✏️</button>
```

CSS:
```css
.edit-hotzone {
    position: fixed; top: 0; left: 0;
    width: 80px; height: 80px;
    z-index: 10000;
    cursor: pointer;
}
.edit-toggle {
    opacity: 0;
    pointer-events: none;
    transition: opacity 0.3s ease;
}
.edit-toggle.show,
.edit-toggle.active {
    opacity: 1;
    pointer-events: auto;
}
```

JS:
```javascript
// 1. Click handler on the toggle button
document.getElementById('editToggle').addEventListener('click', () => {
    editor.toggleEditMode();
});

// 2. Hotzone hover with 400ms grace period
const hotzone = document.querySelector('.edit-hotzone');
const editToggle = document.getElementById('editToggle');
let hideTimeout = null;

hotzone.addEventListener('mouseenter', () => {
    clearTimeout(hideTimeout);
    editToggle.classList.add('show');
});
hotzone.addEventListener('mouseleave', () => {
    hideTimeout = setTimeout(() => {
        if (!editor.isActive) editToggle.classList.remove('show');
    }, 400);
});

// 3. Keyboard shortcut (E key)
document.addEventListener('keydown', (e) => {
    if ((e.key === 'e' || e.key === 'E') && !e.target.getAttribute('contenteditable')) {
        editor.toggleEditMode();
    }
});
```

---

## Viewport Fitting Rules

These invariants apply to EVERY slide in EVERY presentation:

| Rule | CSS | Notes |
|------|-----|-------|
| html/body lock | `height: 100%; overflow-x: hidden` | Prevents horizontal scroll |
| Scroll snap | `scroll-snap-type: y mandatory` | Ensures slide alignment |
| Slide height | `height: 100vh; height: 100dvh` | dvh = dynamic viewport |
| Overflow hidden | `overflow: hidden` | Critical: no slide internal scroll |
| Font scaling | `clamp(min, preferred, max)` | Never fixed px/rem |
| Images | `max-height: min(50vh, 400px)` | Prevents overflow |

### Content Density Limits Per Slide

| Slide Type    | Maximum Content                                           |
| ------------- | --------------------------------------------------------- |
| Title slide   | 1 heading + 1 subtitle + optional tagline                 |
| Content slide | 1 heading + 4-6 bullet points OR 1 heading + 2 paragraphs |
| Feature grid  | 1 heading + 6 cards maximum (2x3 or 3x2)                  |
| Code slide    | 1 heading + 8-10 lines of code                            |
| Quote slide   | 1 quote (max 3 lines) + attribution                       |
| Image slide   | 1 heading + 1 image (max 60vh height)                     |

**Content exceeds limits? Split into multiple slides. Never cram, never scroll.**

---

## CSS Gotchas

### Negating CSS Functions

**WRONG — silently ignored by browsers:**
```css
right: -clamp(28px, 3.5vw, 44px);
margin-left: -min(10vw, 100px);
```

**CORRECT — wrap in `calc()`:**
```css
right: calc(-1 * clamp(28px, 3.5vw, 44px));
margin-left: calc(-1 * min(10vw, 100px));
```

---

## Code Quality

| Aspect | Requirement |
|--------|-------------|
| Comments | Every section needs clear comments explaining what it does and how to modify |
| Semantic HTML | `<section>`, `<nav>`, `<main>` |
| Keyboard nav | Must work fully |
| Accessibility | ARIA labels where needed |
| Reduced motion | Support `prefers-reduced-motion` media query |

---

## Pre-flight Checklist ★

**画完每页 HTML 后，交活前必须逐条自检。不满足 = 不许交活。**

### 视口检查
- [ ] 每个 `.slide` 有 `height: 100vh; height: 100dvh; overflow: hidden`
- [ ] `html` 有 `scroll-snap-type: y mandatory`
- [ ] 内容没有溢出（无内部滚动条）

### 字体检查
- [ ] 用了 Fontshare/Google Fonts（`<link>` 标签）
- [ ] 没有使用系统字体（禁止 Arial, Inter, Roboto 等）

### 动画检查
- [ ] 动画通过 `.visible` class 触发
- [ ] IntersectionObserver 已配置
- [ ] `prefers-reduced-motion` 支持

### 内容密度检查
- [ ] 标题 + 最多 6 个要点，或标题 + 2 段落
- [ ] 超限则拆分到多个 slide
